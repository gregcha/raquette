class RemoveColumnToBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :account_id_id, :integer
    remove_column :bookings, :user_id, :integer
  end
end
