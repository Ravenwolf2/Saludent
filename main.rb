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
	@DB = Sequel.sqlite('db/Saludent.sqlite')
end

# configure :production do
# 	Sequel.postgres('development', :host=>'localhost', :user=>'user', :password=>'password')
# end

require './models/paciente.rb'	#va despues de la conexion a la base de datos porque lo necesita

#Paciente.unrestrict_primary_key

get '/' do
	slim :principal
end

get '/pacientes' do
	slim :pacientes #Paciente.all.to_s
end

get '/pacientes/nuevo' do
	slim :paciente_nuevo
end

post '/pacientes/nuevo' do
	paciente = Paciente.create(
		:dni => params[:dni],
		:nombre => params[:nombre],
		:apellido => params[:apellido]
	)
	redirect to('/pacientes')
end

get '/pacientes/borrar/:dni' do
	Paciente[params[:dni]].delete
	redirect to('/pacientes')
end

get '/prueba' do
	Paciente[32115998].values.to_s
end