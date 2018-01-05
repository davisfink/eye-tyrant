class MonsterType < Sequel::Model
    many_to_many :spells
    one_to_many :monsters
    many_to_many :actions
    many_to_many :legendaries
    many_to_many :traits
end
