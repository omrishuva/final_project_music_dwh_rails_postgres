class Query < ActiveRecord::Base
	
	attr_accessible :args, :fact_id
	belongs_to :fact
	
	serialize :args, ActiveRecord::Coders::Hstore
	serialize :results, Array
	
	class << self
		def create(args , fact)
			query = new
			query_params = { }
			binding.pry
			if fact_aggregations_query?(args)
				add_as_key!(args[:fact][:aggregations], query)
				query_params.merge!('select' => "#{fact_select_string(args[:fact][:aggregations], fact)}" )	
			end

			if group_by_dim_query?(args)
				build_group_by(args, query_params)
				if !by_snow_dim_query?(args)
					query_params.merge!("join" => args[:group].keys.map{ |k| k.to_s } )
				end
			end
			
			if by_snow_dim_query?(args)
				query_params.merge!( 'join' => "#{snow_dims(args)}")
			end

			if by_star_dim_query?(args) && by_snow_dim_query?(args) && fact_where_query?(args)
			
				query_params.merge!( 'where' => "#{full_where_string(args, fact)}")
			
			elsif !fact_where_query?(args) && by_star_dim_query?(args) && by_snow_dim_query?(args)
			
				query_params.merge!( 'where' => "#{dims_where_string(args[:dims])}")
			
			elsif !by_star_dim_query?(args) && by_snow_dim_query?(args) && fact_where_query?(args)
			
				query_params.merge!( 'where' => "#{fact_snow_where_string(args)}")
			
			elsif !by_snow_dim_query?(args) && by_star_dim_query?(args) && fact_where_query?(args)
				
				query_params.merge!( 'where' => "#{dim_filters(args[:dims], fact)} and #{fact_where_string(args[:fact][:where],fact)}")
			
			elsif !by_snow_dim_query?(args) && !fact_where_query?(args) && by_star_dim_query?(args)
				
				query_params.merge!( 'where' => "#{dim_filters(args[:dims], fact)}")

			elsif by_snow_dim_query?(args) && !by_star_dim_query?(args) && !fact_where_query?(args) 

				query_params.merge!( 'where' => "#{fact_where_string(args, fact)}")	
			

			elsif !by_snow_dim_query?(args) && !by_star_dim_query?(args) && fact_where_query?(args) 

				query_params.merge!( 'where' => "#{fact_where_string(args[:dims], fact)}")	
			end
			binding.pry
			query.fact_id = fact.id
			query.args    = query_params
			query.save
			query
		end	
	end


	def execute
		
		case 
			when select_where_join_query? then rslt = select_where_join_query
			when select_where_query?      then rslt = select_where_query
			when select_join_query?       then rslt = select_join_query 	
			when select_query?            then rslt = select_query?
			when where_join_query?        then rslt = where_join_query
			when where_query?             then rslt = where_query 
			when join_query?							then rslt = join_query?							
		end
		rslt
	end		
	
	private

	def format_results(rslt)
		final_result = {}
		results.each do |result_name|
			final_result.merge!(result_name => rslt.send(result_name))
		end
		final_result
	end

	def join_string
		JSON.parse(args['join']).map{ |j| j.to_sym }
	end	

	def join_query
		fact_obj.joins(join_string)
	end

	def where_query
		fact_obj.where(args['where'])
	end

	def select_query
		fact_obj.select(args['select'])
	end

	def select_where_join_query
		fact_obj.joins(join_string).where(args['where']).select(args['select']).group(args["group"])		
	end	
	
	def select_where_query
		if group_query?
			fact_obj.where(args['where']).select(args['select']).group(args["group"])
		else
			fact_obj.where(args['where']).select(args['select']).first
		end
	end

	def select_join_query
		if group_query?
			fact_obj.joins(join_string).select(args['select']).group(args["group"])
		else
			fact_obj.joins(join_string).select(args['select']).first
		end
	end	
	
	#saved query types##########################################################
	
	def join_query?
		args.keys.include? 'join'
	end

	def select_query?
		args.keys.include? 'select'
	end 

	def where_query?
		args.keys.include? 'where'
	end

	def group_query?
		args.keys.include? 'group'
	end	

	def select_where_join_query?
		select_query? && where_query? && join_query?
	end

	def select_where_query?
		select_query? && where_query? && !join_query?
	end

	def select_join_query?
		select_query? && join_query? && !where_query?
 	end

 	def where_join_query?
 		join_query? && where_query? && !select_query?
 	end	

 	def fact_obj
		eval(fact.name.classify)
	end

	class << self
	#query type by args#####################################################################
		def group_by_dim_query?(args)
			args[:group].present?
		end	
		
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
			.flatten.include?(:where) if args[:dims]						
		end	
		
		def by_snow_dim_query?( args )
			args[:dims].keys.map{ |dim| args[:dims][dim].keys }
			.flatten.include?(:snow_dim) if args[:dims]
		end

	#query string utils#################################################################
	
		def add_as_key!(args, query)
			args.keys.each do |key|
				args[key].merge!( as: "#{args[key][:function]}_#{key}" )
				query.results << args[key][:as]
			end
			args
		end	

		def dim_filters(args, fact)
			args.keys.map do |key|
			 "#{fact.table_name}.id IN #{dimension_filter(fact, key, args)}"
			end.join(" and ") 
		end

		def dimension_filter(fact,key, args)
			"(SELECT #{fact.name.downcase}_id FROM #{key} WHERE #{star_dim_where_string(args)})"
		end

		#deprecated
		def in_operator(ids)
			"(#{ids.map{ |id| add_comma!(id) }.join(',')})"
		end	
		def add_comma!(id)
			"'#{id}'"
		end

		def snow_dims(args)
			snow_dims = args[:dims].keys.map{ |dim| args[:dims][dim][:snow_dim].keys }
			if args[:group]
				args[:group].keys.each do |key|
					if dim_obj(key).class == 'SnowDim'
						snow_dims << dim_obj(key)
					end
				end
			end		
			snow_dims.flatten.uniq.map{ |sd| sd.to_s }
		end	
		
		#args[:fact]
		def full_where_string(args, fact)
			[fact_where_string(args[:fact][:where], fact),
			 dims_where_string(args[:dims])
			 ].flatten.compact.join(" AND ")
		end	

		def fact_where_string( fact_where, fact )
			fact_where.keys.map do |key|	
				"#{fact.table_name}.#{key} #{fact_where[key][:operator]} #{fact_where[key][:value]}"
			end.join(" AND ")
		end
		
		#args[:dims]
		def dims_where_string(dims)
		[ star_dim_where_string(dims), snow_dim_where_string(dims)].flatten.join(" AND ")
		end	

		def star_dim_where_string(dims)
			where_string = dims.keys.map do |dim|
					dims[dim][:where].keys.map do |star_key|
					  
					  if dims[dim][:where][star_key][:operator] == "IN"
					 		value =	in_operator(dims[dim][:where][star_key][:value])
					  else
					 		value = dims[dim][:where][star_key][:value]
					  end			

					  "#{dim_obj(dim.to_s).table_name}.#{star_key} #{dims[dim][:where][star_key][:operator]} #{value}"
					end
				end.flatten
			"(#{where_string.join(' AND ')})"	
		end

		def snow_dim_where_string(dims)
			dims.keys.map do |dim|
				dims[dim][:snow_dim].keys.map do |snow|
					dims[dim][:snow_dim][snow][:where].keys.map do |snow_key|
						
						if dims[dim][:snow_dim][snow][:where][snow_key][:operator] == "IN"
				 			value =	in_operator(dims[dim][:snow_dim][snow][:where][snow_key][:value])
				 		else
				 			value = dims[dim][:snow_dim][snow][:where][snow_key][:value]
				 		end

						"#{dim_obj(snow.to_s).table_name}.#{snow_key} #{dims[dim][:snow_dim][snow][:where][snow_key][:operator]} #{value}"
					end		
				end
			end.flatten
		end

		def fact_snow_where_string(args, fact)
			[ snow_dim_where_string(args[:dims]), fact_where_string(args[:fact][:where], fact) ].flatten.join(" AND ")
		end
		
		def fact_star_where_string(args, fact)
			[ star_dim_where_string(args[:dims]), fact_where_string(args[:fact][:where], fact) ].flatten.join(" AND ")
		end
			
		def fact_select_string(args, fact)
			args.keys
			.map{ |key| "#{args[key][:function]}(#{fact.table_name}.#{key}) AS #{args[key][:as]}" } 
			.join(",")
		end	

		def build_group_by(args, query_params)
			group = args[:group].keys.map{ |key| "#{key}.#{args[:group][key]}" }.join(', ')
			query_params.merge!('group' => group )
			query_params["select"] += ", #{group}"
		end			

		#general utils###############################################################	

		def dim_obj(key)
			eval(key.to_s.classify)
		end	
	end	

end

