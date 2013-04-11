class Fact < ActiveRecord::Base
  attr_accessible :name, :table_id
  belongs_to :table
  has_many :star_dims
  has_many :queries
  
  def get_attributes_and_actions
  	aggregations = {}
  		table.attributes.each do |attribute|
  			aggregations.merge!({attribute.attribute_name.to_sym => { function: attribute.fact_actions}}) 
  		end
  	aggregations
  end
  
  def table_name
  	name.tableize
  end	

  def full_dimension_attributes
  	dims = {}
    star_dims.each do |star| 
      dims.merge!(star.get_attributes_and_actions) 
    end
    {dims: dims}
	end  		 

   

end
