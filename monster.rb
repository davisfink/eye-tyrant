class Monster
    def initialize(id, name, size, type, alignment, hit_dice, speed, attributes, senses, languages, challange_rating)
        @id = id.to_i
        @name = name
        @size = size
        @type = type
        @alignment = alignment
        @hit_dice = hit_dice
        @hit_points = Calculate_Hit_Points(@hit_dice)
        @speed = speed
        @attributes = Get_Attributes(attributes)
        @senses = senses
        @languages = languages
        @challange_rating = challange_rating.to_i
    end

    attr_accessor :id, :name, :size, :type, :alignment, :hit_points, :hit_dice, :speed, :attributes,
        :skills, :senses, :languages, :challange_rating, :spells, :abilities, :actions

    def damage(value)
        puts "the #{@name} took #{value} damage"
        @hit_points = @hit_points - value
    end

    def generate_spell_list
        #spell_list = spell_monster_map.collect{ |m, s| m = @id } ? Not sure on this yet
        spells = [
            Spell.new(1, 'Fireball', 3, 'Evocation', '1 round', '120 feet', 'V,S', '1 Action', 'Createsa a fireball'),
            Spell.new(2, 'Lightning Bolt', 3, 'Evocation', '1 round', '120 feet', 'V,S', '1 Action', 'Createsa a lightning bolt'),
            Spell.new(3, 'Fun Time', 3, 'Evocation', '1 round', '120 feet', 'V,S', '1 Action', 'Createsa a fun time')
        ]
    end

    def generate_action_list
    end

end

class Ability
end

class Action
    def initialize(id, name, description)
        @id = id
        @name = name
        @description = description
    end

    attr_accessor :id, :name, :description
end

class Spell
    def initialize (id, name, level, school, casting_time, range, components, duration, description)
        @id = id
        @name = name
        @level = level
        @school = school
        @casting_time = casting_time
        @range = range
        @components = components
        @duration = duration
        @description = description
    end
    attr_accessor :id, :name, :level, :school, :casting_time, :range, :components, :duration, :description
end

def Calculate_Hit_Points(value)
    modifiers = value.split('d').pop.split('+').unshift(value.split('d').shift)
    number_of_dice = modifiers[0].to_i
    dice_value     = modifiers[1].to_i
    modifier       = modifiers[2].to_i || 0

    min = number_of_dice + modifier
    max = number_of_dice * dice_value + modifier
    average = (min + max) / 2
end

def Get_Attributes(set)
    attributes = set.split(',')
    attribute_set = {
        str: attributes[0],
        dex: attributes[1],
        con: attributes[2],
        int: attributes[3],
        wis: attributes[4],
        cha: attributes[5],
    }
end
