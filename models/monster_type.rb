class MonsterType < Sequel::Model
    one_to_many :monsters
end
