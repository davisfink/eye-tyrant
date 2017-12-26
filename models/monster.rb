require './modules/participant_actions.rb'
class Monster < Sequel::Model(:monster)
    include ParticipantActions
end
