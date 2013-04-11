class AddArgsToQuery < ActiveRecord::Migration
  def change
  	add_column :queries, :args, :hstore
  end
end
