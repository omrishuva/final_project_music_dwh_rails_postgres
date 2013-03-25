class QueryTable < ActiveRecord::Migration
  
  def up
  	 rename_table :tables, :dims
  end

  def down
  	rename_table :dims ,:tables 
  end

end
