require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
require './models/condition.rb'

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//condition').each do |s|
    pp s.xpath('name').text
    text_to_add = s.xpath('text').collect do |t| t.xpath('.').text end
    Condition.find_or_create(
        name: s.xpath('name').text,
        description: Sequel.pg_array(text_to_add)
    )
end
