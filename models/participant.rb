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
        @damage + value < hitpoints ? @damage + value : hitpoints
    end

    def heal_damage(value)
        @damage - heal > 0 ? @damage - heal : 0
    end

    def set_initiative(value)
        @initiative = value
    end
end
