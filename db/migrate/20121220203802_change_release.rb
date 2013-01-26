class ChangeRelease < ActiveRecord::Migration
  def up
  	rename_column :albums, :id, :release_7digitalid
  end

  def down
  	  	rename_column :albums, :release_7digitalid, :id 
  end
end
