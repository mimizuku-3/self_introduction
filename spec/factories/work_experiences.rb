FactoryBot.define do
  factory :work_experience do
    introduction
    start_month { "2020-01-01" }
    end_month { "2021-03-31" }
    project_name { "プロジェクト名" }
    project_detail { "プロジェクト詳細" }
    role { 1 }
    role_description { "チームの内訳" }
    language { "PHP" }
    database { "MySQL" }
    server { "Apache Tomcat" }
    fw_mw_tool_etc { "Laravel" }
    responsible_process { "詳細設計" }
  end

  trait :first_work_experience do
    start_month { "2016-01-01" }
    end_month { "2020-12-31" }
  end

  trait :last_work_experience do
    start_month { "2021-04-01" }
    end_month { "2023-12-31" }
  end
end
