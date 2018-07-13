require 'sinatra'
require 'json'
require 'erb'
require 'pp'
require './config/database.rb'
Sequel::Model.plugin :json_serializer
Dir["./models/*.rb"].each {|file| require file }

class Array
  def to_json(options = {:max_nesting=>false})
    JSON.generate(self)
  end
end

class Hash
  def to_json(options = {:max_nesting=>false})
    JSON.generate(self)
  end
end

get '/' do
    @encounter = Encounter.where(active: TRUE).reverse(:id).first
    @party = @encounter.party
    @monsters = @encounter.monsters

    pp @party
    pp @encounter.participants
    pp @monsters

    erb :index
end

get '/encounters/?' do
    @encounters = Encounter.where(active: TRUE).reverse(:id)
    erb :encounters
end

get '/encounter/:id/?' do
    @encounter_id = params[:id]
    @encounter = Encounter.find(id: params[:id])
    difficulty = ChallengeRating.where(level: @encounter.party.level).first
    character_count = @encounter.party.characters.count
    @details = {
        total_experience: @encounter.total_experience,
        adjusted_experience: @encounter.adjusted_experience,
        character_experience: @encounter.per_party_experience,
        party_name: @encounter.party.name,
        party_level: @encounter.party.level,
        easy: difficulty.easy * character_count,
        medium: difficulty.medium * character_count,
        hard: difficulty.hard * character_count,
        deadly: difficulty.deadly * character_count,
    }
    @participants = @encounter.active_participants
    @inactive = @encounter.inactive_participants
    current_monster = @encounter.next_monster
    @mob = MonsterType.find(id: current_monster.monster_type_id) if current_monster
    @conditions = Condition.all

    erb :encounter
end

post '/encounter/:id/next-turn/?' do
    encounter = Encounter.find(id: params[:id])
    encounter.next_participant

    redirect request.referrer
end

get '/generate-encounter/?' do
    @challenge = Experience.all
    @types = Type.all
    @mobs = Encounter.generate(params)
    level = params[:level] || 1
    @count = params[:character_count] || 1
    @count = @count.to_i
    @difficulty = ChallengeRating.where(level: level).first

    erb :generateencounter
end

get '/newencounter/?' do
    @parties = Party.where(active: TRUE)
    @challenge = Experience.all
    @types = Type.all

    erb :newencounter
end

post '/newencounter/?' do
    encounter = Encounter.new_encounter(params)

    redirect "/encounter/#{encounter.id}/"
end

get '/encounter/:id/addmonster/?' do
    @encounter_id = params[:id]

    erb :addmonster
end

post '/encounter/:id/addmonster/?' do
    encounter = Encounter.find(id: params[:id])
    count = params[:number_of].to_i || 1
    (0...count).each do |i|
        encounter.new_participant(params[:monster_type_id])
    end

    redirect "/encounter/#{params[:id]}/"
end

post '/encounter/:id/removemonster/?' do
    @encounter_id = params[:id]
    encounter = Encounter.find(id: @encounter_id)
    encounter.remove_participant(params[:participant_id])

    redirect request.referrer
end


post '/encounter/:id/archive/?' do
    encounter_id = params[:id]
    Encounter.find(id: encounter_id).archive

    redirect request.referrer
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

post '/participant/:id/initiative/:encounter_id/?' do
    encounter = Encounter.where(id: params[:encounter_id]).first
    participant = Participant.where(id: params[:id]).first
    encounter.update_initiative(participant, params[:initiative])

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

    erb :monster
end

get '/monsters/:id/?' do
    @mob = MonsterType.where(id: params[:monster_type_id]).first

    erb :monster
end

get '/get-monster/?' do
    content_type :json
    mob = MonsterType.find(id: params[:id])

    mob.to_json(
        include:
        [
            :type,
            :actions,
            :legendaries,
            :traits,
            :spells,
            :cr
        ]
    )
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
    @party = Party.where(id: params[:id]).first
    @members = @party.characters

    erb :party
end

get '/party/:id/add-member/?' do
    @party = Party.where(id: params[:id]).first
    @characters = Character.all

    erb :addmember
end

post '/party/:id/add-member/?' do
    party_id = params[:id]
    #find party
    party = Party.find(id: party_id)
    #find the character from the query params
    member = Character.find(participant_id: params[:character_id])
    #add the character to the party
    party.add_character(member)

    redirect "/party/#{party_id}/"
end

get '/party/:id/new-character/?' do
    @party = Party.where(id: params[:id]).first
    @races = Race.order(:name)

    erb :newcharacter
end

post '/party/:id/new-character/?' do
    party = Party.where(id: params[:id]).first
    participant = Participant.create()
    character = Character.new(participant_id: participant.id, name: params[:name], races_id: params[:race] )

    party.add_character(character)

    redirect "/party/#{party.id}/"
end

get '/party/:id/remove-character/?' do
    @party = Party.where(id: params[:id]).first

    erb :newcharacter
end

post '/party/:id/remove-character/?' do
    party = Party.where(id: params[:id]).first
    character = Character.where(participant_id: params[:participant_id]).first

    party.remove_character(character)

    redirect "/party/#{party.id}/"
end

post '/party/:id/level-up/?' do
    party = Party.where(id: params[:id]).first
    party.levelUp

    redirect "/party/#{party.id}/"
end

post '/party/:id/level-down/?' do
    party = Party.where(id: params[:id]).first
    party.levelDown

    redirect "/party/#{party.id}/"
end

get '/character-search/?' do
    content_type :json
    @attrs = params
    @results = Character.where(Sequel.ilike(:name, "%#{@attrs[:term]}%"))
    json = @results.map do |result|
        {id: result.id, text: "#{result.name}, #{result.race}"}
    end
    {results: json}.to_json
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

get '/conditions/?' do
    @conditions = Condition.all

    erb :condition
end

get '/map/?' do
    erb :map
end
