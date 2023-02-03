class ChangeIntroductionHobbiesIntroductionIdToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :hobby_introductions, :introduction_id, :bigint
    change_column :hobby_introductions, :hobby_id, :bigint
  end
end
