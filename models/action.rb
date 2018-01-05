class Action < Sequel::Model
    many_to_many :monster_types
end
