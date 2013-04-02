class AttributeCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :attribute_category_relations
  has_many :attributes ,:through => :attribute_category_relations

 

end
