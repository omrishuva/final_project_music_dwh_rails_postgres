class AddTypeToTerm < ActiveRecord::Migration
  def up
  	add_column :terms , :type, :string
  	remove_column :terms ,:freq_avg
  	remove_column :terms ,:weight_avg
  	remove_column :terms ,:strengh
  end
  def down
  	remove_column :terms , :type
  end	
end
