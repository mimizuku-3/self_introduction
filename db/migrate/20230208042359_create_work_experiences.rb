class CreateWorkExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :work_experiences do |t|
      t.date :start_month, null: false
      t.date :end_month, null: false
      t.string :project_name, limit: 200
      t.text :project_detail, limit: 2000
      t.integer :role, limit: 2
      t.text :role_description, limit: 400
      t.text :language, limit: 400
      t.text :database, limit: 400
      t.text :server, limit: 400
      t.text :fw_mw_tool_etc, limit: 400
      t.text :responsible_process, limit: 400

      t.timestamps
    end
  end
end
