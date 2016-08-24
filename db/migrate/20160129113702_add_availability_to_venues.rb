class AddAvailabilityToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :available, :boolean
  end
end
