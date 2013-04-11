class QueriesController < ApplicationController

	def index
		@fact = Fact.all if params[:fact].nil?
		if params[:fact] 
			@fact = fact
			@dims = @fact.full_dimension_attributes
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
		# "action_params"=>{"artist_fam"=>"avg", "songs_count"=>"avg"}
		#  {"terms"=>{"term"=>{"operator"=>"IN", "value"=>"jamaica, reage,dub"}}}
		#  
		binding.pry
	end	


	def query_builder
		redirect_to queries_path and return
	end	
	
	private
	
	# def build_query_params
	# 	{fact:{
	# 		aggregations:{
	# 			build_fact_params
	# 		}
	# 	}		
	# end	
	
	# def build_fact_params
	# 	fact_actions ={}
	# 	params[:fact_actions].keys.each do |key|
	# 		fact_actions.merge!({key.to_sym => params[:fact_actions][key]})
	# 	end
	# 	fact_actions
	# end	

	def fact
		Fact.where(name: params[:fact]).first
	end	

end
