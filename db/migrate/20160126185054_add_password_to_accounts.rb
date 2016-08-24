class AddPasswordToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :password, :string
    remove_column :accounts, :password_hash, :string
    remove_column :accounts, :password_salt, :string
  end
end
