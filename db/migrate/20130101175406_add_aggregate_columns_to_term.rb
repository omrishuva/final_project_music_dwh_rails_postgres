class AddAggregateColumnsToTerm < ActiveRecord::Migration  
  def up
  	add_column :terms, :count, :integer
  	add_column :terms, :freq_avg, :float
  	add_column :terms, :weight_avg, :float
  end

  def down
  	# remove_column :terms, :count
  	# remove_column :terms, :freq_avg
  	# remove_column :terms, :weight_avg
  end

end
