class Table < ActiveRecord::Base
	attr_accessible :name
	has_many :attributes
	has_one :fact
	has_many :star_dims
	has_many :snow_dims	

 	def get_attribute_categories
  	attributes.map{|attribute|attribute.attribute_categories.map{|c| c.name  }.flatten}.flatten.uniq
  end	 

	def table_name(table)
		table.to_s.tableize
	end	
	
	def dim_obj(key)
		eval(key.to_s.classify)
	end	
end
