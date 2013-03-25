class SnowDim < ActiveRecord::Base
   attr_accessible :name, :star_dim_id
   belongs_to :star_dim
end
