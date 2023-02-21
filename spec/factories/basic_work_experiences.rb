FactoryBot.define do
  factory :basic_work_experience do
    introduction
    affiliation { "MyString" }
    nearest_station { "MyString" }
    date_work_start { "2023-02-06" }
    carrer_period { "MyString" }
    is_married { true }
    strong_field { "MyString" }
    strong_technology { "MyString" }
    strong_business { "MyString" }
    self_promotion { "MyText" }
    discarded_at {}
  end
end
