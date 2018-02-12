class Encounter < Sequel::Model
    many_to_many :participants
    many_to_one :party

    def total_experience
        @total_experience ||= experience
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
        self.active_participant_id = active_participants[1].id
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


    def self.new_encounter(params)
        encounter = Encounter.create(party_id: params[:party_id])
        members = Party.find(id: params[:party_id]).characters

        members.each do |member|
            participant = Participant.find(id: member.participant_id)
            participant.set_initiative(0)
            encounter.add_participant(participant)
        end

        mobs = Encounter.generate(params) if params[:cr]

        mobs.each do |m|
            encounter.new_participant(m.id)
        end

        return encounter
    end

    def self.generate(params)
        monsters = MonsterType.where(Sequel.ilike(:name, "%#{params[:term]}%")).exclude(cr:'0').all
        cr = Experience.find(id: params[:cr])
        pp params
        min_cr = Experience.find(id: params[:min_cr]) if params[:min_cr] != ''
        max_cr = Experience.find(id: params[:max_cr]) if params[:max_cr] != ''
        mobs = []

       if min_cr != nil
            monsters.select! do |m|
                m.xp >= min_cr.xp
            end
        end

        if max_cr != nil
            monsters.select! do |m|
                m.xp <= max_cr.xp
            end
        end
 
        pp monsters

        if cr
            total_xp = 0
            while total_xp < cr.xp
                short_list = monsters.select do |m|
                    m.xp <= cr.xp - total_xp
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

