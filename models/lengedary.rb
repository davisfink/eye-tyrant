class Legendary < Sequel::Model(:legendary)
    many_to_one :monster_type
end
