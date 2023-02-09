FactoryBot.define do
  factory :work_experience do
    introduction
    start_month { "2023-01-01" }
    end_month { "2023-03-01" }
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
end
