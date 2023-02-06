class CreateBasicWorkExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :basic_work_experiences do |t|
      t.string :affiliation
      t.string :nearest_station
      t.date :date_work_can_start
      t.string :carrer_period
      t.integer :married
      t.string :strong_field
      t.string :strong_technology
      t.string :strong_business
      t.text :self_promotion

      t.timestamps
    end
  end
end
