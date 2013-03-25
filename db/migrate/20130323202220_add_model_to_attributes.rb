class AddModelToAttributes < ActiveRecord::Migration
  def up
  	add_column :attributes, :model_id ,:integer 
  end

  def down
  	remove_column :attributes, :model_id
  end	
end
