class CreateTotalLeaves < ActiveRecord::Migration[5.0]
  def change
  	drop_table :total_leaves
    create_table :total_leaves do |t|
      t.integer :user_id
      t.integer :annual
      t.integer :maternity
      t.integer :non_paid
      t.integer :study
      t.integer :sick
      t.integer :emergency
    end
  end
end
