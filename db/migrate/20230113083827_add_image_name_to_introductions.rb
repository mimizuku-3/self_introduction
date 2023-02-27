class AddImageNameToIntroductions < ActiveRecord::Migration[5.2]
  def change
    add_column :introductions, :image_name, :string
  end
end
