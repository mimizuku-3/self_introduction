class ChangeHobbiesHobbyNameToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :hobbies, :hobby_name, :string, null: false
  end
end
