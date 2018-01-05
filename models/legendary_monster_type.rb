class LegendaryMonsteType < Sequel::Model(:legendary_monster_types)
    many_to_many :monster_types
    many_to_many :legendary
end
