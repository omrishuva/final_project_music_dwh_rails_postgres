class Fact < ActiveRecord::Base
  attr_accessible :name, :table_id
  belongs_to :table
  has_many :star_dims
  has_many :queries
  

end
