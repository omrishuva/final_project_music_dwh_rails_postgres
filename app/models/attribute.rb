class Attribute < ActiveRecord::Base
	attr_accessible :attribute_name, :attribute_type, :table_id
  has_many :attribute_category_relations
  has_many :attribute_categories ,:through => :attribute_category_relations 
end
