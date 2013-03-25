class RenameDimToStarDim < ActiveRecord::Migration
  def up
  	rename_table :dims, :star_dims
  end

  def down
  	rename_table :star_dim, :dims
  end
end
