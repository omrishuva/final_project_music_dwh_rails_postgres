class AddTermIdToTerm < ActiveRecord::Migration
  
  def up
  add_column :artist_terms, :term_id ,:integer
  end

  def down
  
  end
end
