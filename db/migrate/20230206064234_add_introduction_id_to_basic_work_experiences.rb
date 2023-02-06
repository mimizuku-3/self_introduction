class AddIntroductionIdToBasicWorkExperiences < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM basic_work_experiences;'
    add_reference :basic_work_experiences, :introduction, null: false, index: { unique: true }
  end

  def down
    remove_reference :basic_work_experiences, :introduction, index: { unique: true }
  end
end
