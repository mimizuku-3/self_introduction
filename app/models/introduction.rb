class Introduction < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  has_one_attached :image_name

  enum sex: { male: 0, female: 1}

  validates :name, presence: true
  validates :age, presence: true
  validates :sex, presence: true
  validates :address, presence: true
  validates :prefecture_id, presence: true

  scope :recent, -> {order(created_at: :desc)}
end
