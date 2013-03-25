class Change < ActiveRecord::Migration
  
  def up
  	rename_column :attributes, :model_id, :table_id
  end

  def down
  	rename_column :attributes, :table_id, :model_id
  end

end
