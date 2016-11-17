require 'sinatra'
require 'tilt/erb'

get '/' do
    template = Tilt.new('templates/index.erb')
    template.render(self, :title => 'This is Eye Tyrant')
end
