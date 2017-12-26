require './modules/participant_actions.rb'
class Participant < Sequel::Model(:participant)
    include ParticipantActions

    def initialize(id)
        Participant.find_or_create(id)
    end

end
