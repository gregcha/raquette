class AddReferenceToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :user , index: true
    add_reference :bookings, :account , index: true
  end
end
