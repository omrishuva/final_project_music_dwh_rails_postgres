module QueryHelper
	
	def snow_dim_hidden_field_param(dim)
		unless dim.class.name == 'SnowDim'
			if dim.try(:snow_dims).present?
	    	hidden_field_tag("#{dim.name}_snow", dim.snow_dims.first) 
	  	end
		end
	end	

end
