require 'sinatra'
require 'json'
require 'erb'
require './config/database.rb'
require './models/spell.rb'

get '/' do
    puts 'this works'
end
