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

    def is_monster?
        if monster then true end
    end

    def is_character?
        if character then true end
    end

    def take_damage(value)
        self.damage = [damage + value.to_i, hitpoints].min
        self.save_changes
    end

    def heal_damage(value)
        self.damage = [damage - value.to_i, 0].max
        self.save_changes
    end

    def set_initiative(value)
        self.initiative = value
    end
end
