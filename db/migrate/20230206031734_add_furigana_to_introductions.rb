class AddFuriganaToIntroductions < ActiveRecord::Migration[6.1]
  def up
    add_column :introductions, :furigana, :string
  end

  def down
    remove_column :introductions, :furigana, :string
  end
end
