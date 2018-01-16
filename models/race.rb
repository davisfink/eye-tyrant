class Race < Sequel::Model
    one_to_many :characters
    many_to_many :traits
end
