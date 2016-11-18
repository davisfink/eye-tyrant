require 'sinatra'
require 'tilt/erb'
require 'sequel'
require 'mysql'

get '/' do
    template = Tilt.new('templates/index.erb')
    DB = Sequel.connect('mysql://root:Kadena.1@localhost:3306/eye_tyrant')
    monsters = DB[:monster]

    template.render(self, :title => monsters.first[:name])
end
