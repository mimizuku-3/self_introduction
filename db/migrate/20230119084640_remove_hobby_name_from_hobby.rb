class RemoveHobbyNameFromHobby < ActiveRecord::Migration[5.2]
  def change
    remove_column :hobbies, :hobby_code, :string
    remove_column :hobby_introductions, :hobby_code, :string
  end
end
