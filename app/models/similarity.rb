class Similarity < ActiveRecord::Base
   attr_reader :artist_id, :target_id
   belongs_to :artist,  :class_name => "Artist", :foreign_key => :artist_id
   belongs_to :target, :class_name => "Artist" , :foreign_key => :target_id
   
end
