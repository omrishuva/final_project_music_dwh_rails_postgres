class SnowDim < ActiveRecord::Base
  attr_accessible :name, :star_dim_id, :table_id
  belongs_to :table
  belongs_to :star_dim
end
