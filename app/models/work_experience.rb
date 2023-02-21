class WorkExperience < ApplicationRecord
  include Discard::Model

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

  validate :start_end_check

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

  def diff_years_months(d1, d2)
    # d1の1日を作ってd2を補正
    d2 -= d1 - Date.new( d1.year, d1.month, 1 )

    # 月数で計算
    diff_months = d2.year * 12 + d2.month - d1.year * 12 - d1.month
    diff_months += 1

    # 年月日に戻す
    diff_years = diff_months / 12
    diff_months -= diff_years * 12

    if diff_years == 0
      diff_years_months = "#{diff_months}ヶ月"
    elsif diff_months == 0
      diff_years_months = "#{diff_years}年"
    else
      diff_years_months = "#{diff_years}年#{diff_months}ヶ月"
    end
    return diff_years_months
  end

  def role_as_binary_number
    return self.role_before_type_cast.to_s(2)
  end

  ##############################
  # バリデーション
  ##############################
  def start_end_check
    if self.start_month.present? && self.end_month.present?
      errors.add(:end_month, "は開始年月より後の年月を入力してください。") unless
      self.start_month < self.end_month
    end
  end

end

