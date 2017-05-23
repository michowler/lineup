class RenameImagesToImage < ActiveRecord::Migration[5.0]
  def change
    rename_column :leaves, :images, :image
  end
end
