class Encounter < Sequel::Model
    many_to_many :participants
    many_to_one :party

    def total_experience
        @total_experience ||= experience
    end

    def adjusted_experience
        multiplier = ChallengeMultiplier.where(value: (monsters.count / character_list.count)).first.multiplier
        (@total_experience * multiplier).to_i
    end

    def per_party_experience
        @per_party_experience ||= party_experience
    end

    def turn_order
        order = self.participants.sort_by {|member| member.initiative}.reverse
        active = order.select {|member| member.id == self.active_participant_id }
        next_index = active.first || 0
        next_index = order.index(active.first) || 0
        order.rotate(next_index)
    end

    def active_participants
        turn_order.select {|member| member.active == true }
    end

    def inactive_participants
        self.participants.select {|member| member.active == false }
    end

    def next_participant
        current_p = active_participants.first
        next_p = active_participants[1..-1].find do |p|
            p.is_character? or (p.actor.monster_type_id != current_p.actor.monster_type_id)
        end
        self.active_participant_id = next_p.id
        self.save_changes
    end

    def next_monster
        monster_list.first.monster if monster_list.count > 0
    end

    def monsters
        total_monster_list
    end

    def archive
        self.active = false
        self.save_changes
    end

    def new_participant(id)
        participant = Participant.create()
        monster = MonsterType.find(id: id)

        monster_list = self.participants.select do |p|
            p.actor.name.include? monster.name
        end

        name = monster.name + ' ' + (monster_list.count + 1).to_s

        Monster.create(participant_id: participant.id, monster_type_id: monster.id, name: name)
        participant.calculate_hitpoints
        self.add_participant(participant)
    end

    def update_initiative(participant, initiative)
        if participant.is_monster?
            monster_type = participant.actor.monster_type_id
            monster_list.each do |m|
                if m.actor.monster_type_id == monster_type
                    m.set_initiative(initiative)
                end
            end
        else
            participant.set_initiative(initiative)
        end
    end

    def self.new_encounter(params)
        encounter = Encounter.create(party_id: params[:party_id])
        members = Party.find(id: params[:party_id]).characters

        members.each do |member|
            participant = Participant.find(id: member.participant_id)
            participant.set_initiative(0)
            encounter.add_participant(participant)
        end

        mobs = Encounter.generate(params) if params[:cr]

        if mobs
            mobs.each do |m|
                encounter.new_participant(m.id)
            end
        end

        return encounter
    end

    def self.generate(params)
        #http://dnd.wizards.com/articles/features/building-adventures-0
        #these are the rules for encounter CR The current setup is wrong
        monsters = params[:type_id] != '' ? MonsterType.where(Sequel.ilike(:name, "%#{params[:term]}%")).where(type_id: params[:type_id]).exclude(cr:'0').all : MonsterType.where(Sequel.ilike(:name, "%#{params[:term]}%")).exclude(cr:'0').all
        cr = Experience.find(id: params[:cr]) if params[:cr] != ''
        min_cr = Experience.find(id: params[:min_cr].to_i) || Experience.first
        max_cr = Experience.find(id: params[:max_cr].to_i) || Experience.last
        mobs = []

        if cr
            total_xp = 0
            while total_xp < cr.xp
                short_list = monsters.select do |m|
                    if
                        m.xp <= cr.xp - total_xp and
                            m.xp.between?(min_cr.xp,max_cr.xp)
                        m
                    end
                end

                break if short_list.count == 0
                mob_to_add = short_list.sample
                mobs.push(mob_to_add)
                total_xp += mob_to_add.xp
            end
        end

        return mobs
    end

    private
    def experience
        mobs = total_monster_list
        mobs.inject(0) do |total, participant|
            total + Experience.where(cr: participant.monster.monster_type.cr).first.xp
        end
    end

    def party_experience
        characters = character_list
        total_experience / characters.count
    end

    def monster_list
        monsters = active_participants
        monsters.select do |p| p.is_monster? end
    end

    def total_monster_list
        monsters = self.participants
        monsters.select do |p| p.is_monster? end
    end

    def character_list
        self.participants.select do |p| p.is_character? end
    end

end

