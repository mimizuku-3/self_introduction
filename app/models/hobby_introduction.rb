class HobbyIntroduction < ApplicationRecord
  belongs_to :introduction, touch: true
  belongs_to :hobby

  validates :introduction_id, presence: true
  validates :hobby_id, presence: true
end
