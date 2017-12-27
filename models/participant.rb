class Participant < Sequel::Model
    many_to_many :encounters, class: :Encounter
    one_to_one :monster
    one_to_one :character

    def actor
        case
        when monster then monster
        when character then character
        end
    end

    def take_damage(value)
        self.damage = [damage + value, hitpoints].min
        self.save_changes
    end

    def heal_damage(value)
        self.damage = [damage - value, 0].max
        self.save_changes
    end

    def set_initiative(value)
        self.initiative = value
    end
end
