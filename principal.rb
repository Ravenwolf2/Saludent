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

helpers do
	def crear_paciente
		@paciente = Paciente.create(params[:paciente])
	end

	def buscar_paciente
		@paciente = Paciente[params[:dni]]
	end

	def modificar_paciente
		buscar_paciente
		@paciente.update(params[:paciente])
	end

	def borrar_paciente
		buscar_paciente
		@paciente.delete
	end
end

get '/' do
	slim :principal
end

get '/pacientes' do
	slim :pacientes
end

get '/pacientes/nuevo' do
	@paciente = Paciente.new	#hago esto porque en el form_paciente accedo a @paciente.nombre y si no existe @paciente
	@tipo = :alta 						#da NoMethodError, es solo una variable dummy para que no salte el error
	slim :alta_paciente
end

post '/pacientes/nuevo' do
	crear_paciente
	redirect to('/pacientes')
end

get '/pacientes/modificar/:dni' do
	buscar_paciente
	@tipo = :modificar
	slim :modificar_paciente
end

put '/pacientes/modificar/:dni' do
	modificar_paciente
	redirect to('/pacientes')
end

get '/pacientes/borrar/:dni' do
	borrar_paciente
	redirect to('/pacientes')
end

get '/pedido_primera_consulta' do
end
