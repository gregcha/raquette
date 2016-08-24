class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :district
      t.string :address
      t.string :street
      t.integer :zip_code
      t.string :city
      t.string :phone
      t.text :description
      t.string :surfaces
      t.boolean :handi
      t.string :pt_id
      t.string :pt_name

      t.timestamps null: false
    end
  end
end
