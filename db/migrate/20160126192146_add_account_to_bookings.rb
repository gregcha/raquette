class AddAccountToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :account_id , index: true
  end
end
