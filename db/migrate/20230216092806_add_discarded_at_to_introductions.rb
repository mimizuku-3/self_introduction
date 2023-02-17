class AddDiscardedAtToIntroductions < ActiveRecord::Migration[6.1]
  def up
    add_column :introductions, :discarded_at, :datetime
    add_index :introductions, :discarded_at
  end

  def down
    remove_column :introductions, :discarded_at, :datetime
  end
end
