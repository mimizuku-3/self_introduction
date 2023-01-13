class AddSexToIntroductions < ActiveRecord::Migration[5.2]
  def change
    add_column :introductions, :sex, :integer
  end
end
