class StarDim < ActiveRecord::Base
   attr_accessible :name ,:fact_id
   belongs_to :facts
   has_many :queries
   has_many :snow_dims
end
