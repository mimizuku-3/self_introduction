class AddPrefectureToIntroduction < ActiveRecord::Migration[5.2]
  def change
    add_column :introductions, :prefecture, :integer
  end
end
