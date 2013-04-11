class SnowDim < ActiveRecord::Base
  attr_accessible :name, :star_dim_id, :table_id
  belongs_to :table
  belongs_to :star_dim

  def get_where_params
    where = {}
    table.attributes.each do |attribute|
      where.merge!({ attribute.attribute_name.to_sym => { operator: attribute.dim_actions}})  
    end       
   {snow_dims:{table.name.tableize.to_sym => where}}
  end 

  def table_name
  	name.tableize
  end	

end
