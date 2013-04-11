class AddFactIdToQuery < ActiveRecord::Migration

  def up
  	add_column :queries, :fact_id, :integer
  end

  def down
  	remove_column :queries, :fact_id, :integer
  end	

end
