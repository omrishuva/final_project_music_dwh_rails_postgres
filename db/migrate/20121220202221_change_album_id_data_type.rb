class ChangeAlbumIdDataType < ActiveRecord::Migration
  def up
  	 change_table :albums do |t|
	 	t.change :id, :string
  	end	
  end

end
