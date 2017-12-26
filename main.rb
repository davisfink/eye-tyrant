require 'sinatra'
require 'erb'
require './database.rb'
require './models/encounter.rb'
require './models/participant.rb'
require './models/monster.rb'
require './models/monster_type.rb'
require './models/character.rb'
require './models/encounter_participant.rb'
require './models/experience.rb'
#require './models/spell.rb'
#require './models/action.rb'
require './modules//participant_actions.rb'

get '/' do
    @current_encounter = Encounter.where(:active, "1").first
    @participants = []

    erb :index
end

get '/find-monster/' do
    @search_term = params[:search_term]
    @mob = MonsterType.where(Sequel.ilike(:name, "%#{@search_term}%"))

    erb :monster
end

get '/get-monster/' do
    @mob = MonsterType.find(id: params[:id])

    erb :monster
end

get '/set-initiative/' do
    EncounterParticipant.find(id: params[:id]).update(initiative: params[:value])
    redirect '/'
end

get '/set-damage/' do
    EncounterParticipant.find(id: params[:id]).update(damage: params[:value])
    redirect '/'
end
