module ParticipantActions
    def take_damage(current_damage:, damage:, hitpoints:)
        current_damage + damage < hitpoints ? current_damage + damage : hitpoints
    end

    def heal_damage(current_damage:, heal:)
        current_damage - heal > 0 ? current_damage - heal : 0
    end

    def set_initiative(initiative:)
        initiative
    end
end
