class StarDim < ActiveRecord::Base
   attr_accessible :name ,:fact_id,:table_id
   belongs_to :table
   belongs_to :facts
   has_many :snow_dims
   has_many :attributes

   def build_dimension
   	
   	if	has_snow_dim?
   		[[attributes]] 	
   	end	
   end	

   private

   def get_attributes
   	attributes.map{ |attribute| {name: attribute.name actions:  } }
   		
   	end
   end	
   
   def has_snow_dim?
   	try(:snow_dims)
   end	

end