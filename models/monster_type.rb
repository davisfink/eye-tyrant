class MonsterType < Sequel::Model
    many_to_many :spells
    one_to_many :monsters
    one_to_many :actions
    one_to_many :legendary
end
