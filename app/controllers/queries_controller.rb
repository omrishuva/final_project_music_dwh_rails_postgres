class QueriesController < ApplicationController

	def dashboard
		@facts = Fact.all
	end 
end

private

def get_schema_data
	Fact.all.map{ |fact| {fact:fact.name, star_dims:fact.star_dims,snow_dims:fact.snow_dims } }
end	