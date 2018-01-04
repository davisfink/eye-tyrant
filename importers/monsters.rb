require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
require './models/monster_type.rb'
require './models/action.rb'
require './models/lengedary.rb'

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//monster').each do |m|
    MonsterType.insert(
        name: m.xpath('name').text
        size: m.xpath('name').text
        type: m.xpath('name').text
        alignment: m.xpath('name').text
        ac: m.xpath('name').text
        hp: m.xpath('name').text
        speed: m.xpath('name').text
        str: m.xpath('name').text
        dex: m.xpath('name').text
        con: m.xpath('name').text
        int: m.xpath('name').text
        wis: m.xpath('name').text
        cha: m.xpath('name').text
        skill: m.xpath('name').text
        passive: m.xpath('name').text
        languages: m.xpath('name').text
        cr: m.xpath('name').text
        immune: m.xpath('name').text
        conditionimmune: m.xpath('name').text
        resist: m.xpath('name').text
        trait: m.xpath('name').text
        action: m.xpath('name').text
        legendary: m.xpath('name').text ? null
        spells: m.xpath('spells').text
        description: m.xpath('description')
        slots: m.xpath('slots')
    )
end
