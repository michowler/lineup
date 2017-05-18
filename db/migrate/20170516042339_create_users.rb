class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :name
      t.integer :position
      t.string :email, null: false
      t.integer :department
      t.integer :manager_id
      t.integer :leaves_no   
      t.string  :phone_no
      t.string  :address
      t.string  :avatar
      t.string  :private_token 
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
    end
    add_index :users, :name
    add_index :users, :email
    add_index :users, :remember_token
  end
end
