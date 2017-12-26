require './modules/participant_actions.rb'
class Monster < Sequel::Model
    include ParticipantActions
end
