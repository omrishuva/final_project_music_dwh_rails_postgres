class AddStarDimIdToSnowDim < ActiveRecord::Migration
  def up
  add_column :snow_dims , :star_dim_id , :integer
  end

  def down
  	remove_column :snow_dims , :star_dim_id
  end

end
