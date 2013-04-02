class StarDim < ActiveRecord::Base
   attr_accessible :name ,:fact_id,:table_id
   belongs_to :table
   belongs_to :facts
   has_many :queries
   has_many :snow_dims
end