class Table < ActiveRecord::Base
	attr_accessible :name
	has_many :attributes
	has_many :fact
	has_many :star_dims
	has_many :snow_dims


#perform query##############################################################################
	
	def query!(args)	
	
		add_as_key!(args[:fact][:aggregations]) if fact_aggregations_query?(args)
		
		if where_aggregations_by_star_snow_dim_query?(args)

			rslt = where_aggregations_by_star_snow_dim_query(args)

		elsif aggregations_by_star_snow_dim_query?(args)
		
			rslt = aggregations_by_star_snow_dim_query(args)
		
		elsif where_by_star_snow_dim_query?(args) 

			rslt = where_by_star_snow_dim_query?(args)

		elsif where_aggregations_by_snow_dim_query?(args)

			rslt = where_aggregations_by_snow_dim_query(args)

		elsif aggregations_by_snow_dim_query?(args)

			rslt = where_aggregations_by_snow_dim_query(args)

		elsif where_by_snow_dim_query?(args)

			rslt = where_aggregations_by_snow_dim_query(args)		

		elsif where_aggregations_by_star_dim_query?(args)
		
			rslt = where_aggregations_by_dim_query(args)
		
		elsif aggregations_by_star_dim_query?(args)
		
			rslt = aggregations_by_dim_query(args)
		
		elsif where_aggregations_query?(args) 	
		
			rslt = where_aggregations_query(args)
		
		else			
		
			rslt = aggregations_query(args) 
		
		end
		
		format_results(rslt, args)
	end

#queries##################################################################################
	
	def where_aggregations_by_star_snow_dim_query(args)
		binding.pry
		fact
		.joins(snow_dims(args))
		.where(full_where_string(args))
		.select(select_string(args[:fact][:aggregations]))
	end	

	def aggregations_query( args )
		fact.select(select_string(args[:fact][:aggregations])).first
	end	

	def where_aggregations_query( args )
		fact.where(where_string(args[:fact][:where]))
		.select(select_string(args[:fact][:aggregations])).first
	end	

	def aggregations_by_star_dim_query(args)
		fact.where(where_string(args[:fact][:where]))
	end	

	def where_aggregations_by_dim_query(args)
		fact.where("#{dim_filters(args[:dims])} and #{where_string(args[:fact][:where])}")
		.select(select_string(args[:fact][:aggregations])).first
	end
	
	def aggregations_by_star_snow_dim_query( args )
		fact.joins(@fact_where[:dim])
		.where("#{@fact_where[:attribute]} IN (#{@fact_where[:ids]})")
	end

#query type###########################################################################
	
	#utils##############################################################
	
	def fact_aggregations_query?( args )
		args[:fact].keys.include?(:aggregations)
	end

	def fact_where_query?(args)
		args[:fact].keys.include?(:where)
	end

	def fact_where_aggregations_query?( args )
		fact_where_query?(args) and fact_aggregations_query?(args)
	end

	def by_star_dim_query?( args )
		args[:dims].keys.map{ |dim| args[:dims][dim].keys }
		.flatten.include?(:where) 						
	end	
	
	def by_snow_dim_query?( args )
		args[:dims].keys.map{ |dim| args[:dims][dim].keys }
		.flatten.include?(:snow_dim)
	end

#options##################################################################

	def where_aggregations_by_star_snow_dim_query?(args)
		fact_where_aggregations_query?( args ) and
		by_star_dim_query?(args) and
		by_snow_dim_query?(args)
	end

	def aggregations_by_star_snow_dim_query?(args)
		fact_aggregations_query?(args) and 
		by_star_dim_query?(args[:star_dims]) and
		by_snow_dim_query?(args)
	end

	def where_by_star_snow_dim_query?(args)
		fact_where_query?(args) and
		 by_star_dim_query?(args[:star_dims]) and
		 by_snow_dim_query?(args) 
	end
	
	def where_aggregations_by_snow_dim_query?(args)
		fact_where_aggregations_query?(args) and
		!by_star_dim_query?(args) and
		by_snow_dim_query?(args)
	end
	
	def aggregations_by_snow_dim_query?(args)
		fact_aggregations_query?(args) and
		!by_star_dim_query?(args) and
		by_snow_dim_query?(args)
	end
	
	def where_by_snow_dim_query?(args)
		fact_where_query?(args) and
		!by_star_dim_query?(args) and
		by_snow_dim_query?(args)
	end

	def where_aggregations_by_star_dim_query?(args)
		fact_where_aggregations_query?(args) and
		by_star_dim_query?(args) and
		!by_snow_dim_query?
	end	

	def aggregations_by_star_dim_query?(args)
		fact_aggregations_query?( args) and
		by_star_dim_query?( args) and
		!by_snow_dim_query?
	end			

	def where_by_star_dim_query?(args)
		fact_where_aggregations_query?(args) and
		by_star_dim_query?(args) and
		!by_snow_dim_query?
	end


	#general utils########################################################################
	def format_results(rslt,args)
		final_result = {}
		args[:fact][:aggregations].keys.each do |key|
			result_name =  args[:fact][:aggregations][key][:as]
			final_result.merge!(result_name => rslt.send(result_name))
		end
		final_result
	end

	def add_as_key!(args)
		args.keys.each do |key|
			args[key].merge!( as: "#{args[key][:function]}_#{key}" )
		end
		args
	end	

	def dim_filters(args)
		filters = args.keys.map do |key|
			"#{key.to_s}_id IN (#{dimension_filter(key, args)})"
		end
		filters.join(" and ")
	end	

	def dimension_filter(key, args)
		in_operator( dim_obj(key).where(where_string(args[key][:where]).map(&:id))).join(',')
	end

	def in_operator(args)
		binding.pry
		"(#{args.map{ |obj| add_comma!(obj) }.join(',')})"
	end	

	def add_comma!(id)
		"'#{id}'"
	end

	def snow_dims(args)
		args[:dims].keys.map{ |dim| args[:dims][dim][:snow_dim].keys }.flatten
	end	
	#args[:fact]
	
	def full_where_string(args)
		[fact_where_string(args[:fact][:where]), dims_where_string(args[:dims])].flatten.join(" AND ")
	end	

	def fact_where_string( fact_where )
		fact_where.keys.map do |key|	
			"#{table_name(fact.name)}.#{key} #{fact_where[key][:operator]} #{fact_where[key][:value]}"
		end.join(" AND ")
		
	end
	#args[:dims]
	def dims_where_string(dims)
	[ star_dim_where_string(dims), snow_dim_where_string(dims)].flatten.compact.join(" AND ")
	end	

	def star_dim_where_string(dims)
		dims.keys.map do |dim|
			dims[dim][:where].keys.map do |star_key|
			  
			  if dims[dim][:where][star_key][:operator] == "IN"
			 		value =	in_operator(dims[dim][:where][star_key][:value])
			  else
			 		value = dims[dim][:where][star_key][:value]
			  end			
			  
			  "#{table_name(dim)}.#{star_key} #{dims[dim][:where][star_key][:operator]} #{value}"
			end
		end.flatten
	end

	def snow_dim_where_string(dims)
		dims.keys.map do |dim|
			dims[dim][:snow_dim].keys.map do |snow|
				dims[dim][:snow_dim][snow][:where].keys.map do |snow_key|
					
					if dims[dim][:snow_dim][snow][:where][snow_key][:operator] == "IN"
			 			binding.pry
			 			value =	in_operator(dims[dim][:snow_dim][snow][:where][snow_key][:value])
			 		else
			 			value = dims[dim][:snow_dim][snow][:where][snow_key][:value]
			 		end

					"#{table_name(snow)}.#{snow_key} #{dims[dim][:snow_dim][snow][:where][snow_key][:operator]} #{value}"
				end		
			end
		end.flatten
	end
	
	def select_string(args)
		select_string = args.keys.map do |key|
		 "#{args[key][:function]}(#{key}) AS #{args[key][:as]} "
		end
		select_string.join(",")
	end	

	def table_name(key)
		key.to_s.tableize
	end	
	
	def dim_obj(key)
		eval(key.to_s.classify)
	end	

	def fact
		@fact ||= eval(name)
	end	

end
