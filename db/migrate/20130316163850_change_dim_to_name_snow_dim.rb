class ChangeDimToNameSnowDim < ActiveRecord::Migration
  def up
  	rename_column :snow_dims, :dim, :name
  end

  def down
  	rename_column :snow_dims,:name, :dim
  end
end
