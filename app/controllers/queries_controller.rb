class QueriesController < ApplicationController

	def index
		@fact = Fact.all if params[:fact].nil?
		if params[:fact] 
			@fact = Fact.where(name: params[:fact]).first
			@dims = @fact.star_dims
		end	   

		respond_to do |format|
      format.html # index.html.erb
      format.js {render :queries,layout: false}
    end  
	
	end 
end
