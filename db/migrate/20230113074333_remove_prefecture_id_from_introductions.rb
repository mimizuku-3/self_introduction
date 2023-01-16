class RemovePrefectureIdFromIntroductions < ActiveRecord::Migration[5.2]
  def change
    remove_column :introductions, :prefecture_id, :integer
  end
end
