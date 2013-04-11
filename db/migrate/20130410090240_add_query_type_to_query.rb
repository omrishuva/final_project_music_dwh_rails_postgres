class AddQueryTypeToQuery < ActiveRecord::Migration
  
  def up
	add_column :queries, :query_type, :string  
  end
  
  def down
  	remove_column :queries, :query_type
  end	

end
