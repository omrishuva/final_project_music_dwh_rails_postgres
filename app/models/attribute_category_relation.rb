class AttributeCategoryRelation < ActiveRecord::Base
  
  belongs_to :attribute
  belongs_to :attribute_category
  
  attr_accessible :attribute_id, :attribute_category_id

  def self.build_relation( attributes, category_id )
		
		attributes.each do |attribute|
  		new( attribute_id: attribute.id, attribute_category_id: category_id ).save
  	end
  
  end	

end
