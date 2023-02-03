class HobbyIntroduction < ApplicationRecord
  belongs_to :introduction, touch: true
  belongs_to :hobby
end
