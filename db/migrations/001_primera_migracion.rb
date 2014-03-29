Sequel.migration do
	change do
		create_table(:pacientes) do
			Integer :dni, 		 :primary_key=>true
			String  :nombre,   :null=>false
			String  :apellido, :null=>false
		end
	end
end