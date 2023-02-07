class BasicWorkExperience < ApplicationRecord
  belongs_to :introduction

  validates :date_work_start, date: true
end
