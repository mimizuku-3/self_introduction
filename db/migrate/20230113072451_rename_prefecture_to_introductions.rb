class RenamePrefectureToIntroductions < ActiveRecord::Migration[5.2]
  def change
    rename_column :introductions, :prefecture, :prefecture_id
  end
end
