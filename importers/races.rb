require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
Dir["./models/*.rb"].each {|file| require file }

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//race').each do |m|
    race_to_add = Race.find_or_create(
        name: m.xpath('name').text,
        size: m.xpath('size').text,
        speed: m.xpath('speed').text,
        ability: m.xpath('ability').text,
        proficiency: m.xpath('proficiency').text,
    )

    m.xpath('trait').each do |trait|
        text_to_add = trait.xpath('text').collect do |t| t.xpath('.').text end
        trait_to_add = Trait.find_or_create(
            name: trait.xpath('name').text,
            text: Sequel.pg_array(text_to_add)
        )
        match_trait = race_to_add.traits.select do |t| t == trait_to_add end
        race_to_add.add_trait(trait_to_add) if match_trait.count == 0
    end
    pp race_to_add.name
end
