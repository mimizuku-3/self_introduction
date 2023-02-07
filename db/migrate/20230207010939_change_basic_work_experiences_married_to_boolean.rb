class ChangeBasicWorkExperiencesMarriedToBoolean < ActiveRecord::Migration[6.1]
  def up
    rename_column :basic_work_experiences, :married, :is_married
    change_column :basic_work_experiences, :is_married, :boolean, using: "is_married::boolean", default: false, null: false
  end

  def down
    change_column :basic_work_experiences, :is_married, :integer, using: "is_married::integer"
    rename_column :basic_work_experiences, :is_married, :married
  end
end
