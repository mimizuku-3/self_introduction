class AddDiscardedAtToBasicWorkExperiences < ActiveRecord::Migration[6.1]
  def up
    add_column :basic_work_experiences, :discarded_at, :datetime
    add_index :basic_work_experiences, :discarded_at
    add_column :work_experiences, :discarded_at, :datetime
    add_index :work_experiences, :discarded_at
  end

  def down
    remove_column :basic_work_experiences, :discarded_at, :datetime
    remove_column :work_experiences, :discarded_at, :datetime
  end
end
