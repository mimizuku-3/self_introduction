class ChangeIntroductionHobbiesIntroductionIdToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :hobby_introductions, :introduction_id, :bigint, null: false
    change_column :hobby_introductions, :hobby_id, :bigint, null: false
  end
end
