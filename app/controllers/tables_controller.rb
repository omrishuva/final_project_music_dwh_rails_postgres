class TablesController < ApplicationController
	
	def index
		@tables = Table.all.map{|table| [table.name, table.id ] }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tables }
    end  
	end	
  

  def dashboard
    table = Table.find params["fact_table"]["id"]
    fact = Fact.create( name: table.name, table_id: table.id  )
    if params["selected_star"]
      params["selected_star"].keys.each do |key|
        name = Table.find(params["star"][key]).name.tableize
        fact.star_dims.create( name: name, table_id: params["star"][key].to_i )
      end  
      
      if params["selected_snow"]
        params["selected_snow"].keys.each do |key|
          name = Table.find params["snow"][key].name.tableize
          fact.star_dims.create( name: name, table_id: params["snow"][key].to_i )
        end  
      end
    end  
    redirect_to tables_path
  end

end