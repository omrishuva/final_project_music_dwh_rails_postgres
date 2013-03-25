class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string	:
      t.string
      t.string
      t.string
      t.string
      t.timestamps
    end
  end
end
