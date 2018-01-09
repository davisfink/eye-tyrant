require 'sinatra'
require 'json'
require 'erb'
require 'pp'
require './config/database.rb'
Dir["./models/*.rb"].each {|file| require file }

get '/' do
    erb :index
end

get '/encounters/?' do
    @encounters = Encounter.where(active: TRUE).reverse(:id)
    erb :encounters
end

get '/encounter/:id/?' do
    @encounter_id = params[:id]
    @encounter = Encounter.find(id: params[:id])
    @details = {
        total_experience: @encounter.total_experience,
        character_experience: @encounter.per_party_experience,
        party_name: @encounter.party.name
    }
    @participants = @encounter.active_participants
    @inactive = @encounter.inactive_participants
    current_monster = @encounter.next_monster
    @mob = MonsterType.find(id: current_monster.monster_type_id) if current_monster
    @xp = Experience.find(cr: @mob.cr).xp if current_monster
    @conditions = Condition.all

    erb :encounter
end

post '/encounter/:id/next-turn/?' do
    encounter = Encounter.find(id: params[:id])
    encounter.next_participant

    redirect request.referrer
end


get '/newencounter/?' do
    @parties = Party.where(active: TRUE)
    erb :newencounter
end

post '/newencounter/?' do
    members = Party.find(id: params[:party_id]).characters
    encounter = Encounter.create(party_id: params[:party_id])
    #hey maybe take a look at this sometime and make it suck slightly less.
    #consider looking at the "participant" model and return itself based on
    #a monster or character object
    members.each do |member|
        participant = Participant.find(id: member.participant_id)
        participant.set_initiative(0)
        encounter.add_participant(participant)
    end

    redirect "/encounter/#{encounter.id}/"
end

get '/encounter/:id/addmonster/?' do
    @encounter_id = params[:id]

    erb :addmonster
end

post '/encounter/:id/addmonster/?' do
    @encounter_id = params[:id]
    encounter = Encounter.find(id: @encounter_id)
    participant = Participant.create()
    monster = MonsterType.find(id: params[:monster_type_id])

    Monster.create(participant_id: participant.id, monster_type_id: monster.id, name: monster.name)
    participant.calculate_hitpoints
    encounter.add_participant(participant)

    redirect "/encounter/#{params[:id]}/"

end

get '/participant/:id/damage/?' do
    participant = Participant.where(id: params[:id]).first
    @pid = participant.id

    erb :damage
end

post '/participant/:id/damage/?' do
    participant = Participant.where(id: params[:id]).first
    participant.take_damage(params[:damage])

    redirect request.referrer
end

get '/participant/:id/heal/?' do
    participant = Participant.where(id: params[:id]).first
    @pid = participant.id

    erb :heal
end

post '/participant/:id/heal/?' do
    participant = Participant.where(id: params[:id]).first
    participant.heal_damage(params[:damage])

    redirect request.referrer
end

post '/participant/:id/initiative/?' do
    participant = Participant.where(id: params[:id]).first
    participant.set_initiative(params[:initiative])

    redirect request.referrer
end

get '/participant/:id/add-condition/?' do
    @current_participant = Participant.where(id: params[:id]).first
    @conditions = Condition.reject do |c| @current_participant.conditions.include?(c) end

    erb :addcondition
end

post '/participant/:id/add-condition/?' do
    participant = Participant.where(id: params[:id]).first
    condition = Condition.where(id: params[:condition]).first
    match_condition = participant.conditions.select do |c| condition == c end
    participant.add_condition(condition) if match_condition.count == 0

    redirect request.referrer
end

get '/participant/:id/remove-condition/?' do
    @current_participant = Participant.where(id: params[:id]).first
    @conditions = Condition.all

    erb :removecondition
end

post '/participant/:id/remove-condition/?' do
    participant = Participant.where(id: params[:id]).first
    condition = Condition.where(id: params[:condition]).first
    participant.remove_condition(condition)

    redirect request.referrer
end

get '/find-monster/?' do
    @search_term = params[:term]
    @results = MonsterType.where(Sequel.ilike(:name, "%#{@search_term}%"))

    erb :monster
end

get '/monsters/?' do
    @mob = MonsterType.where(id: params[:monster_type_id]).first
    @xp = Experience.find(cr: @mob.cr).xp if @mob

    erb :monster
end

get '/monsters/:id/?' do
    @mob = MonsterType.where(id: params[:monster_type_id]).first
    @xp = Experience.find(cr: @mob.cr).xp if @mob

    erb :monster
end

get '/get-monster/?' do
    @mob = MonsterType.find(id: params[:id])

    erb :monster
end

get '/monster-search/?' do
    content_type :json
    @attrs = params
    @results = MonsterType.where(Sequel.ilike(:name, "%#{@attrs[:term]}%"))
    json = @results.map do |result|
        {id: result.id, text: result.name}
    end
    {results: json}.to_json
end

get '/parties/?' do
    @parties = Party.where(active: TRUE)
    erb :parties
end

get '/party/:id/?' do
    party_id = params[:id]
    @members = Party.find(id: party_id).characters

    erb :party
end

get '/party/:id/addmember/?' do
    @party_id = params[:id]

    erb :addmember
end

post '/party/:id/addmember/?' do
    party_id = params[:id]
    #find party
    party = Party.find(id: party_id)
    #find the character from the query params
    member = Character.find(participant_id: params[:character_id])
    #add the character to the party
    party.add_character(member)

    redirect "/party/#{party_id}/"
end

get '/spells/?' do
    @spell = Spell.where(id: params[:spell_id]).first

    erb :spell
end

get '/spell-search/?' do
    content_type :json
    @attrs = params
    @results = Spell.where(Sequel.ilike(:name, "%#{@attrs[:term]}%"))
    json = @results.map do |result|
        {id: result.id, text: result.name}
    end
    {results: json}.to_json
end
