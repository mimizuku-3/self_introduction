class BasicWorkExperience < ApplicationRecord
  include Discard::Model

  belongs_to :introduction

  validates :affiliation, length: {maximum: 150}
  validates :nearest_station, length: {maximum: 50}
  validates :carrer_period, length: {maximum: 20}
  validates :strong_field, length: {maximum: 200}
  validates :strong_technology, length: {maximum: 200}
  validates :strong_business, length: {maximum: 200}
  validates :self_promotion, length: {maximum: 2000}

end
