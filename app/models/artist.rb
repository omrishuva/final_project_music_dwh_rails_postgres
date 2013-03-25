class Artist < ActiveRecord::Base
  
  include InstanceAnalysis
  
  attr_reader :artist_name, :artist_hotness, :artist_fam 
  
  has_many :similarities, :class_name => "Similarity", :foreign_key => :artist_id, :dependent => :destroy
  has_many :similarity_relations, :class_name => "Artist", :through => :similarity_relations
  has_many :target_relations, :class_name => "Similarity", :foreign_key => :target_id, :dependent => :destroy
  has_many :targets, :class_name => "Artist", :through => :targets_relations
  has_many :songs ,:foreign_key => :artist_id
  has_many :artist_terms,:foreign_key => :artist_id
  has_many :artist_terms
  has_many :terms ,:through=>:artist_terms 
  has_many :artist_albums
  has_many :albums ,:through=>:artist_albums
    
  def get_songs_by_years
    query_results = Song.has_year.where(id:artist_id).select("count(song_id),year").order(:year).group(:year)
    final_results = []
    query_results.each do |qr|
      final_results << {year:qr[:year], count:qr.count }
    end  
  final_results
  end  

  def term_by_categories
   term_categories = Term.split_by_categories(artist_terms)
   term_categories.sort_by!{|t| t.size}.reverse!
   term_categories.each do |category|
    category.sort_by!{|c| c[:freq] || c[:weight]}.reverse!
   end 
  term_categories
  end  

  def get_main_geners
    terms.main.order("artist_terms.freq DESC,artist_terms.weight")
  end

  def get_artists_by_ids(ids)
    artist_ids = Artist.where(id:ids)
    Song.songs_by_artist(artist_ids,"info" )
  end

  def years_range
    {
     max_year: songs.has_year.maximum(:year).to_i,
     min_year: songs.has_year.minimum(:year).to_i,
     avg_year: songs.has_year.average(:year).to_i,
     stdev: songs.has_year.select("stddev(year)")[0][:stddev].to_i
    }
  end  

end

