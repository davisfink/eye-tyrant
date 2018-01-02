class Party < Sequel::Model
    one_to_many :characters
end
