class CreateQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :queries do |t|
      t.string :pt_court_id
      t.string :date
      t.string :hour
      t.string :pt_id
      t.string :cle
      t.string :libelleReservation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
