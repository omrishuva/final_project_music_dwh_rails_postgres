class ChangeColumNameTypeInTerm < ActiveRecord::Migration
  def up
  	rename_column :terms , :type , :category
  end

  def down
    rename_column :terms ,:category, :type 
  end
end
