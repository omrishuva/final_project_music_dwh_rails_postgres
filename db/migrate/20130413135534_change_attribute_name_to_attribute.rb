class ChangeAttributeNameToAttribute < ActiveRecord::Migration
  def up
    rename_column :attributes, :attribute_name, :name
  end

  def down
    rename_column :attributes,:name, :attribute_name
  end
end
