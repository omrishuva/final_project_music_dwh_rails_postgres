class CreateSnowDims < ActiveRecord::Migration
  def change
    create_table :snow_dims do |t|
      t.string :dim
      t.string :relation

      t.timestamps
    end
  end
end
