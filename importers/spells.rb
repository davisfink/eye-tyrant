require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
require './models/spell.rb'

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//spell').each do |s|
    spell_to_add = Spell.find_or_create(
        name: s.xpath('name').text,
        level: s.xpath('level').text,
        school: s.xpath('school').text,
        time: s.xpath('time').text,
        range: s.xpath('range').text,
        components: s.xpath('components').text,
        duration: s.xpath('duration').text,
        classes: s.xpath('classes').text,
    )
    text = s.xpath('text').collect do |t| t.xpath('.').text end
    roll = s.xpath('roll').collect do |t| t.xpath('.').text end
    spell_to_add.text = Sequel.pg_array(text)
    spell_to_add.roll = Sequel.pg_array(roll)
end
