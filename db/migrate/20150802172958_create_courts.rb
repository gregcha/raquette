class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.integer :court_number
      t.string :surface
      t.boolean :roof
      t.boolean :lights
      t.string :pt_court_id
      t.string :pt_venue_id
      t.string :pt_court_and_venue_id
      t.references :venue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
