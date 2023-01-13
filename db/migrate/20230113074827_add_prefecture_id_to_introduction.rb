class AddPrefectureIdToIntroduction < ActiveRecord::Migration[5.2]
  def change
    add_column :introductions, :prefecture_id, :integer
  end
end
