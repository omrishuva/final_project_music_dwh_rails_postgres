class ChangeTableColumnName < ActiveRecord::Migration
  
  def up
  	rename_column :tables, :type, :table_type
  end
  
  def down
  	rename_column :tables, :table_type, :type
  end

end
