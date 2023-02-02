class RemoveImageNameFromIntroduction < ActiveRecord::Migration[6.1]
  def up
    remove_column :introductions, :image_name
  end

  def down
    add_column :introductions, :image_name, :string
  end
end
