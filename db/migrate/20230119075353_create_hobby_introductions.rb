class CreateHobbyIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :hobby_introductions do |t|
      t.integer :introduction_id
      t.string :hobby_code

      t.timestamps
    end
  end
end
