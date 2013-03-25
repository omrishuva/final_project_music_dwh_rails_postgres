class AddFactIdToStarDim < ActiveRecord::Migration
  
  def up
	add_column :star_dims, :fact_id , :integer  
  end
  
  def down
  	remove_column :star_dims, :fact_id
  end	

end
