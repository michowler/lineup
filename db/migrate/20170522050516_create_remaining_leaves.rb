class CreateRemainingLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :remaining_leaves do |t|
      t.integer :user_id
      t.integer :annual
      t.integer :maternity
      t.integer :non_paid
      t.integer :study
      t.integer :sick
      t.integer :emergency
      t.timestamps
    end

    add_column :users, :remaining_leafe_id, :integer
    add_index :leaves, :user_id
    add_index :leaves, :manager_id
    add_index :total_leaves, :user_id
    add_index :remaining_leaves, :user_id
    add_index :users, :manager_id
    add_index :users, :total_leafe_id
    add_index :users, :remaining_leafe_id
  end
end
