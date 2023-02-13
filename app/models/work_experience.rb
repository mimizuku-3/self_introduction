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

  enum role: { 
    zero: 0, 
    PG: 1, 
    SE:2, 
    SE_PG:3, 
    PL:4,
    PL_PG: 5, 
    PL_SE: 6, 
    PL_SE_PG: 7, 
    PM: 8, 
    PM_PG: 9, 
    PM_SE: 10, 
    PM_SE_PG: 11, 
    PM_PL: 12, 
    PM_PL_PG: 13, 
    PM_PL_SE: 14, 
    PM_PL_SE_PG: 15, 
  }

  def set_role_by_bit_management(roles)
    sum_role = 0
    roles.each do |role|
      sum_role += role.to_i
    end
    self.role = sum_role
  end

end

