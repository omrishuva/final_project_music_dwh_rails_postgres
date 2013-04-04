class Table < ActiveRecord::Base
	attr_accessible :name
	has_many :attributes
	has_many :fact
	has_many :star_dims
	has_many :snow_dims
end
