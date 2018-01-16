class Character < Sequel::Model
    Character.unrestrict_primary_key
    one_to_one :participant
    many_to_one :party
    many_to_one :race

    def race
        Race.where(id: self.races_id).first.name
    end
end
