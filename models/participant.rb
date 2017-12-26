class Participant < Sequel::Model(:participant)
    def initialize(id)
        Participant.find_or_create(id)
    end

    def take_damage(value)
        @damage += value ? @damage += value < @hitpoints : @damage = @hitpoints
    end

    def heal_damage(value)
        @damage -= value ? @damage == value > 0 : @damage = 0
    end

    def set_initiative(value)
        @initiative = value
    end

end
