class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :court, index: true, foreign_key: true
      t.string :date
      t.string :hour

      t.timestamps null: false
    end
  end
end
