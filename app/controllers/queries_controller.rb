class QueriesController < ApplicationController

	def index
		@fact = Fact.all if params[:fact].nil?
		if params[:fact]
			@fact = fact
		end
		if params[:args]
			@results = Query.create(args, fact).execute
		end
	respond_to do |format|
      format.html # index.html.erb
      format.js {render :queries,layout: false}
    end  
	
	end 
	
	def create
		binding.pry
		@results = Query.create(build_query_params, fact).execute
	end

	private
	
	def build_query_params
	  case 
	  
	  	when params[:action_params] && params[:dims_params] && params[:group] then
	  	 	group_by_with_dim_filters_query
	 	  
	 	  when params[:action_params] && params[:group] then group_by_query
	 	  
	 	  when 	params[:action_params] && params[:dims_params] then fact_aggregations_with_dim_filters 
	  
	  end  
	
	end
	
	def group_by_query
		{ fact: {aggregations: build_fact_hash } }.merge!( {  group: params[:group] } )
	end	
	
	def group_by_with_dim_filters_query
		{ fact: {aggregations: build_fact_hash } }
		.merge!({dims: build_complete_dims_hash })
		.merge!( { group: params[:group] } )
	end

	def fact_aggregations_with_dim_filters
		{ fact: {aggregations: build_fact_hash } }
		.merge!({dims: build_complete_dims_hash })
	end

#build
	def build_fact_hash
		aggregations = {}
		params[:action_params].keys.each do |key|
			aggregations.merge!({key.to_sym => {function: params[:action_params][key] }})	
		end	
		aggregations
	end
	
	def build_complete_dims_hash
		snow_dim_keys = []
		params[:dims_params].keys.each do |key|
			snow_dim_keys << params[key] if params[key]
		end
		
		star_dim_keys = params[:dims_params].keys - snow_dim_keys
		star_dims = build_dim_hash(star_dim_keys)
		star_dim_keys.each do |star_key|
			if params[:dims_params][star_key][params[star_key]]
				snow_dim = build_dim_hash( [params[star_key]] )
				star_dims[star_key.to_sym].merge!({ snow_dim: snow_dim })
			end	
		end	
	star_dims
	end

	def build_dim_filters(dim ,attribute)
		{ attribute.to_sym => {
			operator: params[:dims_params][dim][attribute][:operator],
			value: params[:dims_params][dim][attribute][:value],
			}
		}
	end	

	def build_dim_hash(dims)
		dims_hash = {}
		dims.each do |dim|
			dim_filters = {}
			binding.pry
			params[:dims_params][dim].keys.each do |attribute|
				dim_filters.merge!(build_dim_filters(dim,attribute))
			end
			dims_hash.merge!({dim.to_sym => {where: dim_filters}})
		end
		dims_hash
	end	

	def fact
		Fact.where(name: params[:fact]).first
	end	

end
