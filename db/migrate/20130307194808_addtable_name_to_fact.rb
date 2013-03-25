class AddtableNameToFact < ActiveRecord::Migration
  def up
  	add_column :facts, :name, :string
  end

  def down
  	remove_column :facts, :name
  end
end
