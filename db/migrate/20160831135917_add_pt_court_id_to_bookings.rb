class AddPtCourtIdToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :pt_court_id, :string
  end
end
