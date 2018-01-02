class Party < Sequel::Model
    one_to_many :characters
    one_to_many :encounters
end
