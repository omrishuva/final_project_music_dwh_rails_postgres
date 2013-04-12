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

		binding.pry
	end	


	def query_builder
		redirect_to queries_path and return
	end	
	
	private
	
	def build_query_params
	# 	{"utf8"=>"✓",
 # "authenticity_token"=>"ENDl/XdDK7MhbNSoOstHhPxUeyKJSwaY7frYRKVKRrs=",
 # "fact"=>"Artist",
 # "button_action"=>"similars_count",
 # "action_params"=>
 #  {"artist_hotness"=>"avg",
 #   "artist_fam"=>"avg",
 #   "songs_count"=>"avg",
 #   "similars_count"=>"avg"},
 # "artist_terms_snow"=>"terms",
 # "selected"=>{"term"=>"term"},
 # "dims_params"=>{"terms"=>{"term"=>{"operator"=>"group by", "value"=>""}}},
 # "artist_albums_snow"=>"albums",
 # "similarities_snow"=>"artists",
 # "action"=>"create",
 # "controller"=>"queries"}
 		
	
	end
	
	def build_fact_hash
		params[:action_params].keys.each do |key|
			params[:action_params][key]
		end	
	end
	
	def build_dims_hash
	end	

	def fact
		Fact.where(name: params[:fact]).first
	end	

end
