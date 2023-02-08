class WorkExperience < ApplicationRecord
  belongs_to :introduction

  validates :start_month, presence: true
  validates :end_month, presence: true
  validates :project_name, length: {maximum: 200}
  validates :project_detail, length: {maximum: 2000}
  validates :role_description, length: {maximum: 400}
  validates :language, length: {maximum: 400}
  validates :database, length: {maximum: 400}
  validates :server, length: {maximum: 400}
  validates :fw_mw_tool_etc, length: {maximum: 400}
  validates :responsible_process, length: {maximum: 400}

end

