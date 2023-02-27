class RenameDateWorkStartToBasicWorkExperiences < ActiveRecord::Migration[6.1]
  def up
    rename_column :basic_work_experiences, :date_work_can_start, :date_work_start
  end
  
  def down
    rename_column :basic_work_experiences, :date_work_start, :date_work_can_start
  end
end
