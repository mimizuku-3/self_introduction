class Hobby < ApplicationRecord
  has_many :hobby_introductions
  has_many :introductions, through: :hobby_introductions, dependent: :destroy
end
