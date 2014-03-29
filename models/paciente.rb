class Paciente < Sequel::Model
	self.unrestrict_primary_key #Sin esto no me deja asignar :dni al crear un nuevo registro
end
