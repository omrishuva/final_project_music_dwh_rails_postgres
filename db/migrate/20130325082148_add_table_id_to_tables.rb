class AddTableIdToTables < ActiveRecord::Migration
  
  def up
  	add_column :facts, :table_id, :integer
  	add_column :snow_dims, :table_id, :integer
  	add_column :star_dims, :table_id, :integer
  end

  def down
  	remove_column :facts, :table_id
  	remove_column :snow_dims, :table_id
  	remove_column :star_dims, :table_id
  end	

end
