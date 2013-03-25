class AddSimilaritiesCountToArtist < ActiveRecord::Migration
  
  def up
  	add_column :artists , :similars_count, :integer, :default => 0
  end
  
  def down
  	remove_column :artists , :similars_count
  end	
end
