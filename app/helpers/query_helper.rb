module QueryHelper
	
	def display_attributes(klass)
		columns = klass.columns.map{ |column| { name: column.name, type: column.type } }			
		columns.reject!{ |column|  column[:name].scan(/id/).present? }
	end	
	
	def display_dims(klass)
		fact =  Fact.find_by_name(klass.to_s)
		{
			star_dims: fact.star_dims.map(&:name),
			snow_dims: fact.star_dims.each{ |star| star.try(:snow_dims).map(&:name) }.flatten.compact 
		}	
	end	
	

end
