class CreateTotalLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :total_leaves do |t|
      t.integer :leave_no
      t.integer :annual
      t.integer :maternity
      t.integer :non_paid
      t.integer :study
      t.integer :sick
      t.integer :emergency
    end
    
  end
end
