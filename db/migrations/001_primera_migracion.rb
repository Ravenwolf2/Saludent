Sequel.migration do
	change do
		create_table(:pacientes) do
			primary_key :id
			Integer 		:dni, 		 :unique=>true
			String  		:nombre,   :null=>false
			String  		:apellido, :null=>false
		end
	end
end