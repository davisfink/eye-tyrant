require './modules/participant_actions.rb'
class Participant < Sequel::Model
    many_to_many :encounters, class: :Encounter
    include ParticipantActions

    def initialize(id)
        Participant.find_or_create(id)
    end

end
