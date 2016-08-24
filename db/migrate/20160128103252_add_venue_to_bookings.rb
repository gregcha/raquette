class AddVenueToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :venue , index: true
  end
end
