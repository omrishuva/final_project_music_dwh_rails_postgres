class RenameCategoryToAttributeCategory < ActiveRecord::Migration
  def up
  	rename_column :attribute_category_relations,:category_id,:attribute_category_id
  end

  def down
  	rename_column :attribute_category_relations,:attribute_category_id,:category_id
  end
end
