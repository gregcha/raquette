class RenameQueriesToResults < ActiveRecord::Migration[5.0]
  def change
    rename_table :queries, :results
  end
end
