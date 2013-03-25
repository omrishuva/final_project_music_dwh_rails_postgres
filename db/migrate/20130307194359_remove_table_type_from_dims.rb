class RemoveTableTypeFromDims < ActiveRecord::Migration
  def up
  	remove_column :dims ,:table_type
  end

  def down
  	add_column :dims ,:table_type , :string
  end
end
