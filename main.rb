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

#leaving this here for easier testing in IRB
#@party = Encounter.find(active:1).participants
#puts @party[1].actor.monster_type.name

get '/' do
    @latest_encounter = Encounter.where(:active, "1").first

    erb :index
end

get '/encounters/' do
    @encounters = Encounter.where(:active, "1")
    erb :encounters
end

get '/encounter/:id/' do
    @encounter = Encounter.find(id: params[:id])
    @participants = @encounter.participants

    erb :encounter
end

get '/encounter/:id/addmonster/' do
    @encounter_id = params[:id]

    erb :addmonster
end

post '/encounter/:id/addmonster/' do
    @encounter_id = params[:id]
    encounter = Encounter.find(id: @encounter_id)
    participant = Participant.create()
    monster = MonsterType.find(id: params[:monster_type_id])

    Monster.create(participant_id: participant.id, monster_type_id: monster.id, name: monster.name)
    encounter.add_participant(participant)

    redirect "/encounter/#{params[:id]}/"

end

get '/find-monster/' do
    @search_term = params[:search_term]
    @results = MonsterType.where(Sequel.ilike(:name, "%#{@search_term}%"))

    erb :monster
end

get '/get-monster/' do
    @mob = MonsterType.find(id: params[:id])

    erb :monster
end

