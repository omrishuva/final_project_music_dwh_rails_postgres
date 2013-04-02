class QueriesController < ApplicationController

	def index
		@tables = Table.all
	end 
end

private

def get_schema_data
	Table.all
end	