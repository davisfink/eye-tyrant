require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
require './models/experience.rb'

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//row').each do |s|
    pp s.xpath('field[@name="cr"]').text
    Experience.find_or_create(
        cr: s.xpath('field[@name="cr"]').text,
        xp: s.xpath('field[@name="xp"]').text.to_i
    )
end
