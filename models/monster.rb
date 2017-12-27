class Monster < Sequel::Model
    Monster.unrestrict_primary_key
    one_to_one :participant
    many_to_one :monster_type
end
