class AddHobbyIdToHobbyIntroduction < ActiveRecord::Migration[5.2]
  def change
    add_column :hobby_introductions, :hobby_id, :integer
  end
end
