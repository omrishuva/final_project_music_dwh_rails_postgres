class AddAlterNameToAttributes < ActiveRecord::Migration
  
  def up
  	add_column :attributes, :alter_name, :string
  end
  
  def down
  	remove_column :attributes, :alter_name, :string
  end	

end
