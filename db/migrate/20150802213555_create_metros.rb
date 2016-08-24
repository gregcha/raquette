class CreateMetros < ActiveRecord::Migration
  def change
    create_table :metros do |t|
      t.string :station
      t.references :venue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
