class CreateLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :leaves do |t|
    	t.integer	:user_id
    	t.integer	:manager_id
    	t.integer	:type
    	t.string	:leave_reason
    	t.integer	:status
    	t.string	:rejection_reason
    	t.date		:start_date
    	t.date 		:end_date
    	t.integer	:total_days
      t.timestamps
    end
  end
end
