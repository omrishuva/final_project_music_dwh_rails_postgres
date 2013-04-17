class ArtistsController < ApplicationController

  def analysis
    if params[:search]
      @items = Artist.where( artist_name: params[:search].strip.downcase ).first.analyze
    end
        
    respond_to do |format|
      format.html
      format.js {render :analysis,layout: false}
    end  
  
  end  

end