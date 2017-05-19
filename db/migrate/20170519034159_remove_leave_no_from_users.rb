class RemoveLeaveNoFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :leaves_no
  end
end

