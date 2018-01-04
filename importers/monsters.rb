require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
require './models/monster_type.rb'
require './models/action.rb'
require './models/lengedary.rb'
require './models/trait.rb'

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//monster').each do |m|
    mob_to_add = MonsterType.new(
        name: m.xpath('name').text,
        size: m.xpath('size').text,
        type: m.xpath('type').text,
        alignment: m.xpath('alignment').text,
        ac: m.xpath('ac').text,
        hp: m.xpath('hp').text,
        speed: m.xpath('speed').text,
        str: m.xpath('str').text.to_i,
        dex: m.xpath('dex').text.to_i,
        con: m.xpath('con').text.to_i,
        int: m.xpath('int').text.to_i,
        wis: m.xpath('wis').text.to_i,
        cha: m.xpath('cha').text.to_i,
        skill: m.xpath('skill').text,
        passive: m.xpath('passive').text,
        languages: m.xpath('languages').text,
        cr: m.xpath('cr').text,
        immune: m.xpath('immune').text,
        conditionimmune: m.xpath('conditionImmune').text,
        resist: m.xpath('resist').text,
        spells: m.xpath('spells').text,
        description: m.xpath('description').text,
        slots: m.xpath('slots').text
    )

    m.xpath('action').each do |action|
        action_to_add = Action.new(
            name: action.xpath('name').text,
            text: action.xpath('text').collect do |t| t.xpath('.').text end,
            attack: action.xpath('attack').text
        )
        pp action_to_add
    end
    m.xpath('legendary').each do |leg|
        leg_to_add = Legendary.new(
            name: leg.xpath('name').text,
            text: leg.xpath('text').collect do |t| t.xpath('.').text end,
            attack: leg.xpath('attack').text
        )
        pp leg_to_add
    end
    m.xpath('trait').each do |trait|
        trait_to_add = Trait.new(
            name: trait.xpath('name').text,
            text: trait.xpath('text').collect do |t| t.xpath('.').text end,
        )
        pp trait_to_add
    end
end
