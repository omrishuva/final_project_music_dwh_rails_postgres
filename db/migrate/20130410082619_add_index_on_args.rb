class AddIndexOnArgs < ActiveRecord::Migration
  def up
  	execute "CREATE INDEX queries_args ON queries USING GIN(args)"
  end

  def down
  	execute "DROP INDEX queries_args"
  end
end