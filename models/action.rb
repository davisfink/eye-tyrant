class Action < Sequel::Model
    many_to_one :monster_type
end
