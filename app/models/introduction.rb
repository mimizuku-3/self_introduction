class Introduction < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  include Discard::Model

  belongs_to :prefecture
  has_many :hobby_introductions
  has_many :hobbies, through: :hobby_introductions, dependent: :destroy
  accepts_nested_attributes_for :hobby_introductions, allow_destroy: true

  has_one_attached :image

  has_one :basic_work_experience
  has_many :work_experiences

  enum sex: { male: 0, female: 1}

  validates :name, presence: true
  validates :furigana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'は全角カタカナで入力して下さい。'}
  validates :age, presence: true
  validates :sex, presence: true
  validates :address, presence: true
  validates :prefecture_id, presence: true

  scope :recent, -> {order(created_at: :desc)}

  def work_experiences
    return WorkExperience.where(introduction_id: self.id).kept.order(start_month: :desc)
  end
  
end
