class StaticPagesController < ApplicationController
  
  def home
  	@songs_num = Artist.sum(:songs_count)
  	@artist_num = Artist.count(:id)
  	@terms_num = Term.count(:id)
  	@artist_terms_num = Term.sum(:count)
  	@albums_num = Album.count(:release_7digitalid)
  	@artist_similarities_num = Artist.sum(:similars_count)
  end	

end
