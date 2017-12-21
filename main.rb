require 'sinatra'
require 'erb'
require './database.rb'
require './models/encounter.rb'
require './models/monster.rb'
require './models/encounter_participant.rb'
require './models/experience.rb'
#require './models/spell.rb'
#require './models/action.rb'

get '/' do
    @current_encounter = Encounter.where(:active, "1").first
    @participants = EncounterParticipant.where(:encounter_id, @current_encounter.id.to_s).order(Sequel.desc(:initiative))

    erb :index
end

get '/find-monster/:search_term/*' do
    @search_term = params[:search_term]
    @mob = Monster.where(Sequel.ilike(:name, "%#{@search_term}%"))

    erb :index
end

get '/set-initiative/' do
    EncounterParticipant.find(id: params[:id]).update(initiative: params[:value])
    redirect '/'
end

get '/set-damage/' do
    EncounterParticipant.find(id: params[:id]).update(damage: params[:value])
    redirect '/'
end
