class CreateHobbies < ActiveRecord::Migration[5.2]
  def change
    create_table :hobbies do |t|
      t.string :hobby_code
      t.string :hobby_name
      t.timestamps
    end
  end
end
