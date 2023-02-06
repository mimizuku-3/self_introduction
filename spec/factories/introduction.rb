FactoryBot.define do
  factory :introduction do
    name {'フジ　太郎'}
    furigana {'フジ　タロウ'}
    age {29}
    address {'港区西麻布３丁目２０−６ 杉友ビル2F'}
    content {'テストデータです！！'}
    sex {0}
    prefecture_id {1}
  end
end