class CreateTable < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end
