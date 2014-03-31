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
	#@DB = Sequel.postgres('Saludent', :host=>'localhost', :user=>'postgres', :password=>'psql')
	@DB = Sequel.sqlite('db/sqlite/Saludent.sqlite')
end

configure :production do
	@DB = Sequel.connect(ENV['DATABASE_URL'])
end

#va despues de la conexion a la base de datos porque la necesita
require './models/paciente.rb'

helpers do
	def crear_paciente
		@paciente = Paciente.create(params[:paciente])
	end

	def buscar_paciente
		@paciente = Paciente[:dni => params[:dni]]
	end

	def modificar_paciente
		buscar_paciente
		@paciente.update(params[:paciente])
	end

	def borrar_paciente
		buscar_paciente
		@paciente.delete
	end

	def dummy_paciente
		#Variable dummy
		#En :form_paciente/@paciente.nombre, si no existe @paciente da NoMethodError
		@paciente = Paciente.new
	end
end

get '/' do
	slim :principal
end

get '/pacientes' do
	slim :pacientes
end

get '/pacientes/nuevo' do
	dummy_paciente
	slim :alta_paciente
end

post '/pacientes/nuevo' do
	crear_paciente
	redirect to('/pacientes')
end

get '/pacientes/modificar/:dni' do
	buscar_paciente
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
	dummy_paciente
	slim :pedido_primera_consulta
end
