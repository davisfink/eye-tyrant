require 'sequel'
require 'nokogiri'
require 'pp'
require './config/database.rb'
Dir["./models/*.rb"].each {|file| require file }

file_location = ARGV[0] || ''
doc = File.open(file_location) { |f| Nokogiri::XML(f) }

doc.xpath('//monster').each do |m|
    mob_to_add = MonsterType.find_or_create(
        name: m.xpath('name').text,
        size: m.xpath('size').text,
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
        senses: m.xpath('senses').text,
        vulnerable: m.xpath('vulnerable').text,
        save: m.xpath('save').text,
        skill: m.xpath('skill').text,
        passive: m.xpath('passive').text,
        languages: m.xpath('languages').text,
        cr: m.xpath('cr').text,
        immune: m.xpath('immune').text,
        conditionimmune: m.xpath('conditionImmune').text,
        resist: m.xpath('resist').text,
        description: m.xpath('description').text,
        slots: m.xpath('slots').text
    )

    m.xpath('action').each do |action|
        text_to_add = action.xpath('text').collect do |t| t.xpath('.').text end
        action_to_add = Action.find_or_create(
            name: action.xpath('name').text,
            text: Sequel.pg_array(text_to_add),
            attack: action.xpath('attack').text
        )
        match_action = mob_to_add.actions.select do |a| a == action_to_add end
        mob_to_add.add_action(action_to_add) if match_action.count == 0
    end
    m.xpath('legendary').each do |leg|
        text_to_add = leg.xpath('text').collect do |t| t.xpath('.').text end
        leg_to_add = Legendary.find_or_create(
            name: leg.xpath('name').text,
            text: Sequel.pg_array(text_to_add),
            attack: leg.xpath('attack').text
        )
        match_leggo = mob_to_add.legendaries.select do |l| l == leg_to_add end
        mob_to_add.add_legendary(leg_to_add) if match_leggo.count == 0
    end
    m.xpath('trait').each do |trait|
        text_to_add = trait.xpath('text').collect do |t| t.xpath('.').text end
        trait_to_add = Trait.find_or_create(
            name: trait.xpath('name').text,
            text: Sequel.pg_array(text_to_add)
        )
        match_trait = mob_to_add.traits.select do |t| t == trait_to_add end
        mob_to_add.add_trait(trait_to_add) if match_trait.count == 0
    end
    m.xpath('spells').text.split(',').each do |s|
        spell = Spell.where(Sequel.ilike(:name, s.strip)).first
        match_spell = mob_to_add.spells.select do |s| spell == s end
        mob_to_add.add_spell(spell) if match_spell.count == 0 and spell
    end

    type_tmp = m.xpath('type').text.split(/\W/)
    type_name = type_tmp.shift
    type_to_add = Type.find_or_create(name: type_name)
    mob_to_add.update(type_id: type_to_add.id)

    pp mob_to_add.name
end
