class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :gender
      t.string :first_name
      t.string :last_name
      t.string :birthdate
      t.string :address1
      t.string :address2
      t.integer :zip_code
      t.string :city
      t.string :email
      t.string :mobile_phone
      t.string :perso_phone
      t.string :pro_phone
      t.integer :coins
      t.string :identifiant
      t.string :password_hash
      t.string :password_salt

      t.timestamps null: false
    end
  end
end
