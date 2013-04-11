class AddResultstoQuery < ActiveRecord::Migration
  def up
  	add_column :queries, :results, :text
  end

  def down
  	remove_column :queries, :results
  end
end
