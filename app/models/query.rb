class Query < ActiveRecord::Base
	belongs_to :fact
	belongs_to :dims
	
	# def initialize( fact ,dims =nil )
		
	# 	@qparams = {
	# 		from: { #classes
	# 			fact: fact[:class], #fact table class
	# 			dims: dims.select { |dim| dim[:class] } #array of dimension class 
	# 		},
	# 		where: { #formatted where expresions
	# 			dim:  build_dim_filters(dims), 
	# 			fact: build_filters(dims)
	# 		},
	# 		group_by: { #formatted attributes to group by
	# 			fact: fact[:group],
	# 			dim: dims.select { |dim| dim[:group] 
	# 			},
	# 		having: { #formatted having expresions
	# 			fact: fact[:having],
	# 			dim:  dim[:having]
	# 		},
	# 		select: {
	# 			attributes: { #selected attributes 
	# 				fact: fact[:select],
	# 				dim:  dim[:select]
	# 			},
	# 			calc: { #calculated or aggregated attributes
	# 				fact: fact[:calc],
	# 				dim:  dim[:calc]
	# 			},
	# 		relationship: dims ? analyze_relation(dim[:class]) : nil 
	# 	}
	
	# end	
	
	def query_type_analyzer
		#analyzes by the user params what kind of query to execute
		#To DO : come up with query types
		#only fact queries:
		#
		#fact 
		#develop an algorithm that consider all possible options for queries
	end	
	
	def return_existing_query_params

	end	

	def execute(action = nil)
		
		case query_type_analyzer
			when :star then segment! 
			
		end		
	end

	def build_dim_filters(dims)
		dims.select { |dim| dim[:where] }
	end	

	def build_fact_filters(dims)
		formated_filters = []
		dims.each do |dim|
			case @relation
				when :star       then attribute = dim[:class].to_star_foreign_key
				when :snow_flake then attribute = dim[:class].to_snow_foreign_key		
			end

			formated_filters << {
		 		dim: dim[:class].to_table.to_sym, 
		 		relation: relation.to_s,
		 		fk: @relation == :star ? dim[:class].to_star_fk : dim[:class].to_snow_fk,
		 		ids: dim[:class].where(@dim_where).map(&:id).join(',')
		  }
		end
	formated_filters.first
	end	
	
	def get_association(dim)
		fact_dim_relation = @fact.reflect_on_association(dim.to_table.to_sym).try(:macro)
		unless fact_dim_relation
			fact_dim_relation = @fact.reflect_on_association(dim.to_table.singularize.to_sym).try(:macro)
		end
		fact_dim_relation
	end	
	
	def analyze_relation(dim)
		relation = get_association(dim)
		case relation 
			when :belongs_to then relation_type = :star
			when :has_many   then relation_type = :snow_flake 						
		end
		relation_type	
	end	

	def star_relation_query
		@fact.valid_attributes(@fact_subject).where(@fact_filters[:attribute]=> @fact_filters[:ids])
	end	
	
	def snow_flake_relation_query
		@fact.valid_attributes(@fact_subject).joins(@fact_where[:dim])
		.where("#{@fact_where[:attribute]} IN (#{@fact_where[:ids]})")
	end	

	def avg
		snow_flake_relation_query.group(@dim_groups.first).average(@fact_calc)
	end	
	
	#results manipulation			
	
	def segment! 
		place_in_groups!(divide_to_groups(@fact_calc))
	end

	def place_in_groups!(groups)
		 groups.each do |group|
		 	results = { objects: @data.select{ |d| d[@fact_subject]>group[:min] && d[@fact_subject]<group[:max] } } 
			results.merge!( { count: results[:objects].size } )
			group.merge!(results)
		end	
	end	

	def divide_to_groups( dim_ids,group_num = 5  )		
			
			max = @params[:from][:fact].maximum(@params[:select][:calc])
			min = @params[:from][:fact].minimum(@params[:select][:calc])
			diff = (max - min)/group_num
			
			groups = []
			groups << { min: min , max: min + diff }

			(group_num -1).times.with_index do |idx| 
				groups << { min: groups[idx][:max] , max: groups[idx][:max] + diff }
			end	
			groups
	end	
	
end	


