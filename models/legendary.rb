class Legendary < Sequel::Model
    many_to_many :monster_types
end
