class Introduction < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  enum sex: { male: 0, female: 1}

  validates :prefecture_id, numericality: { other_than: 1 } 

end
