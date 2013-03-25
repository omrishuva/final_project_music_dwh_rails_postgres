class Fact < ActiveRecord::Base
  attr_accessible :name
  has_many :star_dims
  has_many :queries
  

end
