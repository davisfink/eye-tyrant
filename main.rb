require 'sinatra'
require 'json'
require 'erb'
require './database.rb'
require './models/encounter.rb'
require './models/participant.rb'
require './models/monster.rb'
require './models/monster_type.rb'
require './models/character.rb'
require './models/party.rb'
require './models/encounter_participant.rb'
require './models/experience.rb'
#require './models/spell.rb'
#require './models/action.rb'

#leaving this here for easier testing in IRB
@encounter = Encounter.where(active: "1").first
@party = Encounter.where(active: "1").first.participants
@mob = @party[2]

get '/' do
    erb :index
end

get '/encounters/' do
    @encounters = Encounter.where(:active, "1").reverse(:id)
    erb :encounters
end

get '/encounter/:id/' do
    @encounter_id = params[:id]
    @encounter = Encounter.find(id: params[:id])
    @details = {
        total_experience: @encounter.total_experience,
        character_experience: @encounter.per_party_experience,
        party_name: @encounter.party.name
    }
    @participants = @encounter.participants.sort_by {|member| member.initiative}.reverse

    erb :encounter
end

get '/newencounter/' do
    @parties = Party.where(active: "1")
    erb :newencounter
end

post '/newencounter/' do
    members = Party.find(id: params[:party_id]).characters
    encounter = Encounter.create(party_id: params[:party_id])
    #hey maybe take a look at this sometime and make it suck slightly less.
    #consider looking at the "participant" model and return itself based on
    #a monster or character object
    members.each do |member|
        encounter.add_participant(Participant.find(id: member.participant_id))
    end

    redirect "/encounter/#{encounter.id}/"
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
    participant.calculate_hitpoints
    encounter.add_participant(participant)

    redirect "/encounter/#{params[:id]}/"

end

get '/participant/:id/damage/' do
    participant = Participant.where(id: params[:id]).first
    @pid = participant.id

    erb :damage
end

post '/participant/:id/damage/' do
    participant = Participant.where(id: params[:id]).first
    participant.take_damage(params[:damage])

    redirect request.referrer
end

get '/participant/:id/heal/' do
    participant = Participant.where(id: params[:id]).first
    @pid = participant.id

    erb :heal
end

post '/participant/:id/heal/' do
    participant = Participant.where(id: params[:id]).first
    participant.heal_damage(params[:damage])

    redirect '/encounters/'
end

post '/participant/:id/initiative/' do
    participant = Participant.where(id: params[:id]).first
    participant.set_initiative(params[:initiative])

    redirect request.referrer
end

get '/find-monster/' do
    @search_term = params[:term]
    @results = MonsterType.where(Sequel.ilike(:name, "%#{@search_term}%"))

    erb :monster
end

get '/get-monster/' do
    @mob = MonsterType.find(id: params[:id])

    erb :monster
end

get '/monster-search/' do
    content_type :json
    @attrs = params
    @results = MonsterType.where(Sequel.ilike(:name, "%#{@attrs[:term]}%"))
    json = @results.map do |result|
        {id: result.id, text: result.name}
    end
    {results: json}.to_json
end

get '/parties/' do
    @parties = Party.where(:active, "1")
    erb :parties
end

get '/party/:id/' do
    party_id = params[:id]
    @members = Party.find(id: party_id).characters

    erb :party
end

get '/party/:id/addmember/' do
    @party_id = params[:id]

    erb :addmember
end

post '/party/:id/addmember/' do
    party_id = params[:id]
    #find party
    party = Party.find(id: party_id)
    #find the character from the query params
    member = Character.find(participant_id: params[:character_id])
    #add the character to the party
    party.add_character(member)

    redirect "/party/#{party_id}/"
end
