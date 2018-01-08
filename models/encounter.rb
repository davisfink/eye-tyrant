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
        self.active_participant_id = turn_order[1].id
        self.save_changes
    end

    def next_monster
        monster_list.first.monster if monster_list.count > 0
    end

    private
    def experience
        mobs = monster_list
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

    def character_list
        self.participants.select do |p| p.is_character? end
    end
end

