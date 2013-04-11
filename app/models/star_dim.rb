class StarDim < ActiveRecord::Base
  attr_accessible :name ,:fact_id,:table_id
  belongs_to :table
  belongs_to :facts
  has_many :snow_dims
  has_many :attributes

  def get_attributes_and_actions 	 
   	where_params = get_where_params
   	where_params[name.to_sym].merge!(snow_dims.first.get_where_params) if has_snow?.present?		  
    where_params
  end
	
  def get_where_params
    where = {}
    table.attributes.each do |attribute|
  		where.merge!({ attribute.attribute_name.to_sym => { operator: attribute.dim_actions}}) 	
		end	 	 		
   {table.name.tableize.to_sym => where}
  end	

  def table_name
    name.tableize
  end

  private
   
  def has_snow?
  	try(:snow_dims)
  end	

    

end