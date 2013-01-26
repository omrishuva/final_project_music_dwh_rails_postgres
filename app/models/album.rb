class Album < ActiveRecord::Base
   attr_accessible :name,:album_id
   has_many :songs , :foreign_key => :album_id
end
