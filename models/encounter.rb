class Encounter < Sequel::Model
    many_to_many :participants, class: :Participant
    dataset
end

