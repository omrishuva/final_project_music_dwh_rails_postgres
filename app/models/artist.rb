class Artist < ActiveRecord::Base
   #include EchonestResource::Base
   #echonest_resource :artist
   attr_reader :artist_name, :artist_hotness, :artist_fam 
  has_many :similarities, :class_name => "Similarity", :foreign_key => :artist_id, :dependent => :destroy
  has_many :similarity_relations, :class_name => "Artist", :through => :similarity_relations
  has_many :target_relations, :class_name => "Similarity", :foreign_key => :target_id, :dependent => :destroy
  has_many :targets, :class_name => "Artist", :through => :targets_relations
  has_many :songs ,:foreign_key => :artist_id
  has_many :artist_terms,:foreign_key => :artist_id
  has_many :artist_terms
  has_many :terms ,:through=>:artist_terms 
end
def get_artists_by_ids(ids)
artist_ids = Artist.where(artist_id:ids)
Song.songs_by_artist(artist_ids,"info" )
end
