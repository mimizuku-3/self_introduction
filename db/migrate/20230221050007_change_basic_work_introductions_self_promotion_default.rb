class ChangeBasicWorkIntroductionsSelfPromotionDefault < ActiveRecord::Migration[6.1]
  def up
    change_column :basic_work_experiences, :self_promotion, :text, default: ''
  end

  def down
    change_column :basic_work_experiences, :self_promotion, :text
  end
end
