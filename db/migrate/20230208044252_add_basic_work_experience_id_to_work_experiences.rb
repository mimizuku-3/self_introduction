class AddBasicWorkExperienceIdToWorkExperiences < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM work_experiences;'
    add_reference :work_experiences, :introduction, null: false, index: true
  end

  def down
    remove_reference :work_experiences, :introduction, index: true
  end
end
