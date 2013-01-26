class RemoveTimeStampsFromSimlirity < ActiveRecord::Migration
  def up
      remove_column :similarities, :created_at
      remove_column :similarities, :updated_at
  end

end
