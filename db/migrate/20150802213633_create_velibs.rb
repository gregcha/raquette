class CreateVelibs < ActiveRecord::Migration
  def change
    create_table :velibs do |t|
      t.string :station
      t.string :address
      t.references :venue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
