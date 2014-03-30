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

get '/' do
	slim :principal
end

get '/pacientes' do
	slim :pacientes
end

get '/pacientes/nuevo' do
	slim :alta_paciente
end

post '/pacientes/nuevo' do
	Paciente.create(
		:dni => params[:dni],
		:nombre => params[:nombre],
		:apellido => params[:apellido]
	)
	redirect to('/pacientes')
end

get '/pacientes/modificar/:dni' do
	@paciente = Paciente[params[:dni]]
	slim :modificar_paciente
end

put '/pacientes/modificar/:dni' do
	Paciente[params[:dni]].update(
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
	slim :prueba
end