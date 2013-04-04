class QueriesController < ApplicationController

	def index
		@facts = Fact.all if params[:fact].nil?
		if params[:fact] 
			@facts = Fact.where(name: params[:fact]) 
			@dims = @facts.first.star_dims
		end	   

		respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tables }
    end  
	
	end 
end

private

def get_schema_data
	Table.all
end	