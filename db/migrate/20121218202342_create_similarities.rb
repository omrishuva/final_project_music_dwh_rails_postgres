class CreateSimilarities < ActiveRecord::Migration
  def change
    create_table :similarities do |t|
    	t.string :artist_id
    	t.string :target_id

      t.timestamps
    end
  end
end
