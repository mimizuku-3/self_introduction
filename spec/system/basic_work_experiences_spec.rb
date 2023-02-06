require 'rails_helper'

describe '職務経歴書管理機能', type: :system do
  let(:introduction_a) {
    FactoryBot.create(:introduction,
      name: '1件目の自己紹介',
      furigana: 'イッケンメノジコショウカイ',
      age: 19,
      address: '港区西麻布3丁目20−6 杉友ビル2F',
      sex: 1,
      prefecture_id: 13,
      content: '1件目の自己紹介です!!',
      created_at: '2023-01-29 00:00:00',
      updated_at: '2023-01-30 00:00:00'
    )
  }
  let!(:basic_work_experience_a) {
    FactoryBot.create(:basic_work_experience,
    introduction: introduction_a,
    affiliation: '株式会社フジボウル',
    nearest_station: '六町駅',
    date_work_can_start:'2023-03-01',
    carrer_period: '6年6ヶ月',
    married: 0,
    strong_field: 'プログラミング',
    strong_technology: 'PHP / JavaScript / MySQL / HTML',
    strong_business: '環境構築',
    self_promotion: '私のアピールポイントは、どのようなプログラム言語でも、すぐに順応できるプログラム力です。'
    )
  }


  ################################
  # 共通期待値
  ################################
  shared_examples_for '自己紹介Aの職務経歴が表示されること' do
    it { expect(page).to have_content 'イッケンメノジコショウカイ' }
    it { expect(page).to have_content '株式会社フジボウル' }
    it { expect(page).to have_content '1件目の自己紹介' }
    it { expect(page).to have_content '女性' }
    it { expect(page).to have_content '六町駅' }
    it { expect(page).to have_content '19歳' }
    it { expect(page).to have_content '2023-03-01' }
    it { expect(page).to have_content 0 }
    it { expect(page).to have_content '6年6ヶ月' }
    it { expect(page).to have_content 'プログラミング' }
    it { expect(page).to have_content 'PHP / JavaScript / MySQL / HTML' }
    it { expect(page).to have_content '環境構築' }
    it { expect(page).to have_content '私のアピールポイントは、どのようなプログラム言語でも、すぐに順応できるプログラム力です。' }
  end

  describe '職務経歴 基本情報の表示' do
    context '自己紹介一覧画面から遷移した時' do
      before do
        basic_work_experience_a
        visit basic_work_experience_path(introduction_a)
      end
      it_behaves_like '自己紹介Aの職務経歴が表示されること'
    end
  end
end