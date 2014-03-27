require 'sinatra/base'
require 'sinatra/reloader' if settings.development?
#require 'sinatra/flash'
#require 'pony'
require 'slim'
#require 'sass'
require 'sequel'

#require 'v8'
#require 'coffee-script'

configure :development do
	@DB = Sequel.sqlite('development.db')
end

# configure :production do
# 	Sequel.postgres('development', :host=>'localhost', :user=>'user', :password=>'password')
# end

get '/' do
	slim :home
end

get '/db' do
	Sequel.sqlite('development.db')[:songs].all.to_s
end

