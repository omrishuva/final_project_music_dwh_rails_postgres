class CreateAttributesCategoriesRelations < ActiveRecord::Migration
  def change
    create_table :attribute_category_relations do |t|
    	t.integer :attribute_id
    	t.integer :category_id
      t.timestamps
    end
  end
end
