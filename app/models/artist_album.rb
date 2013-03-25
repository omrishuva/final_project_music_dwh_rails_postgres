class ArtistAlbum < ActiveRecord::Base
  # attr_accessible :title, :body
belongs_to :artist
belongs_to :album  
end
