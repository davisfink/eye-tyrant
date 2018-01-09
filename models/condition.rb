class Condition < Sequel::Model
    many_to_many :participants
end
