class Encounter < Sequel::Model
    many_to_many :participants, class: :Participant
    many_to_one :party

    def total_experience
        @total_experience ||= experience
    end

    def per_party_experience
        @per_party_experience ||= party_experience
    end

    private
    def experience
        mobs = self.participants.select do |p| p.is_monster? end
        mobs.inject(0) do |total, participant|
            total + Experience.where(cr: participant.monster.monster_type.cr).first.xp
        end
    end

    def party_experience
        characters = self.participants.select do |p| p.is_character? end
        total_experience / characters.count
    end
end

