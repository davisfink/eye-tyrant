class Character < Sequel::Model
    Character.unrestrict_primary_key
    one_to_one :participant
    many_to_one :party
end
