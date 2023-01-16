class CreateIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :introductions do |t|
      t.string :name
      t.integer :age
      t.string :address
      t.text :content

      t.timestamps
    end
  end
end
