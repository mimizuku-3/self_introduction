class ChangeIntroductionsNamesToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :introductions, :name, :string, null: false
    change_column :introductions, :age, :integer, null: false
    change_column :introductions, :address, :string, null: false
    change_column :introductions, :sex, :integer, null: false
    change_column :introductions, :prefecture_id, :integer, null: false
  end
end
