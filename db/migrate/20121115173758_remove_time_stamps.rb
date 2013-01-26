class RemoveTimeStamps < ActiveRecord::Migration
  def down
  	 	remove_column :albums, :created_at
 		remove_column :albums, :updated_at
  end
end
