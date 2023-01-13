class Introduction < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  enum sex: { male: 0, female: 1}
end
