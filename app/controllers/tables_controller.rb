class TablesController < ApplicationController
	
	def index
		@tables = Table.all.map{|table| [table.name, table.id ] }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tables }
    end  
	end	
  

  def dashboard  
    table = Table.find_or_create_by_id params[:fact_table][:id]
    fact = Fact.create( name: table.name, table_id: table.id  )
       
    if params[:selected_star]
      params[:selected_star].keys.each do |key|
        table_star = Table.find(params[:star][key])
        star = fact.star_dims.create(
          name: table_star.name.tableize,
          table_id: table_star.id )

        if params[:selected_snow] and params[:selected_snow].keys.include? key
          table_snow = Table.find params[:snow][params[:selected_snow].keys[key.to_i]]   
          star.snow_dims.create( 
            name: table_snow.name.tableize,
            table_id: table_snow.id )
        end
      end
    end  
      
    redirect_to tables_path and return
  end

end