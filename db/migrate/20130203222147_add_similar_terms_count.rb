class AddSimilarTermsCount < ActiveRecord::Migration
  def up
  	add_column :terms ,:genre_count , :integer
  end

  def down
  	remove_column :terms ,:genre_count
  end
end
