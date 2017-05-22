class ChangeDataType < ActiveRecord::Migration[5.0]
  def change
  	change_column :leaves, :images, :string
  	add_column :users, :total_annual_leaves, :integer
  end
end
