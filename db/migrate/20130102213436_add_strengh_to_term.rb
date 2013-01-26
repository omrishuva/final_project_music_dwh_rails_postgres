class AddStrenghToTerm < ActiveRecord::Migration
  def up
  	  	add_column :terms, :strengh, :integer

  end
end
