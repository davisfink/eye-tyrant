require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
require './models/challenge_rating.rb'

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//challenge_rating').each do |s|
    pp s.xpath('level').text
    ChallengeRating.find_or_create(
        level: s.xpath('level').text.to_i,
        easy: s.xpath('easy').text.tr(',','').to_i,
        medium: s.xpath('medium').text.tr(',','').to_i,
        challenging: s.xpath('challenging').text.tr(',','').to_i,
        hard: s.xpath('hard').text.tr(',','').to_i
    )
end
