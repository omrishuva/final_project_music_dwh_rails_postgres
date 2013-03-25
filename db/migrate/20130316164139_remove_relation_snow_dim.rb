class RemoveRelationSnowDim < ActiveRecord::Migration
  def up
  	remove_column :snow_dims , :relation
  end

  def down
  	add_column :snow_dims , :relation, :integer
  end
end
