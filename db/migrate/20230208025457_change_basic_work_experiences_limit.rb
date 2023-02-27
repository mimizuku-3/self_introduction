class ChangeBasicWorkExperiencesLimit < ActiveRecord::Migration[6.1]
  def up
    change_column :basic_work_experiences, :affiliation, :string, limit: 150
    change_column :basic_work_experiences, :nearest_station, :string, limit: 50
    change_column :basic_work_experiences, :carrer_period, :string, limit: 20
    change_column :basic_work_experiences, :strong_field, :string, limit: 200
    change_column :basic_work_experiences, :strong_technology, :string, limit: 200
    change_column :basic_work_experiences, :strong_business, :string, limit: 200
    change_column :basic_work_experiences, :self_promotion, :text, limit: 2000
  end

  def down
    change_column :basic_work_experiences, :affiliation, :string
    change_column :basic_work_experiences, :nearest_station, :string
    change_column :basic_work_experiences, :carrer_period, :string
    change_column :basic_work_experiences, :strong_field, :string
    change_column :basic_work_experiences, :strong_technology, :string
    change_column :basic_work_experiences, :strong_business, :string
    change_column :basic_work_experiences, :self_promotion, :text
  end
end
