class AddImagesToLeaves < ActiveRecord::Migration[5.0]
  def change
    add_column :leaves, :images, :json
  end
end
