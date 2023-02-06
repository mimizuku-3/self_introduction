FactoryBot.define do
  factory :basic_work_experience do
    introduction_id { "" }
    affiliation { "MyString" }
    nearest_station { "MyString" }
    date_work_can_start { "2023-02-06" }
    carrer_period { "MyString" }
    married { 1 }
    strong_field { "MyString" }
    strong_technology { "MyString" }
    strong_business { "MyString" }
    self_promotion { "MyText" }
  end
end
