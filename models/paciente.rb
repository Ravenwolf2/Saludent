class Paciente < Sequel::Model
	#Sin esto no me deja asignar :dni al crear un nuevo registro
	self.unrestrict_primary_key
end
