class ArtistsController < ApplicationController

  def analysis
    @dimensions = Artist.dimensions
    if params[:search]
      @items = Artist.where( artist_name: params[:search].strip ).first.analyze
    end
        
    respond_to do |format|
      format.html
      format.js {render :analysis,layout: false}
    end  
  
  end  

end