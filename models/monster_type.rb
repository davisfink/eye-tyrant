class MonsterType < Sequel::Model
    many_to_many :spells
    one_to_many :monsters
    many_to_many :actions
    many_to_many :legendaries
    many_to_many :traits
    many_to_one :type

    def xp
        Experience.where(cr: self.cr).first.xp || 0
    end
end
