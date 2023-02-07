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
    date_work_start:'2023-03-01',
    carrer_period: '6年6ヶ月',
    is_married: false,
    strong_field: 'プログラミング',
    strong_technology: 'PHP / JavaScript / MySQL / HTML',
    strong_business: '環境構築',
    self_promotion: 'すぐに順応できるプログラム力です。'
    )
  }


  ################################
  # 共通期待値
  ################################
  shared_examples_for '自己紹介Aの職務経歴が表示されること' do
    it {
      expect(page).to have_content 'イッケンメノジコショウカイ'
      expect(page).to have_content '株式会社フジボウル'
      expect(page).to have_content '1件目の自己紹介'
      expect(page).to have_content '女性'
      expect(page).to have_content '六町駅'
      expect(page).to have_content '19歳'
      expect(page).to have_content '2023-03-01'
      expect(page).to have_content 'なし'
      expect(page).to have_content '6年6ヶ月'
      expect(page).to have_content 'プログラミング'
      expect(page).to have_content 'PHP / JavaScript / MySQL / HTML'
      expect(page).to have_content '環境構築'
      expect(page).to have_content 'すぐに順応できるプログラム力です。'
    }
  end


  ################################
  # 職務経歴書 表示
  ################################
  describe '職務経歴 基本情報の表示' do
    context '自己紹介一覧画面から遷移した時' do
      before do
        basic_work_experience_a
        visit basic_work_experience_path(introduction_a)
      end
      it_behaves_like '自己紹介Aの職務経歴が表示されること'
    end
  end

  ################################
  # 職務経歴書 基本情報機能
  ################################
  describe '職務経歴書 基本情報編集機能' do
    before do
      basic_work_experience_a
      visit basic_work_experience_path(introduction_a)
      click_on '個人情報・自己PRを編集する'
    end

    context '編集画面を開いたとき' do
      it_behaves_like '自己紹介Aの職務経歴が表示されること'
    end

    context '保存して戻るを押したとき' do
      before do
        fill_in '所属', with: '株式会社フジボウル 編集後'
        fill_in '最寄り駅', with: '六町駅 編集後'
        fill_in '稼働', with: '2023-04-01'
        choose 'あり'
        fill_in '経歴', with: '10年6ヶ月'
        fill_in '得意分野', with: 'プログラミング 編集後'
        fill_in '得意技術', with: 'PHP / JavaScript / MySQL / HTML 編集後'
        fill_in '得意業務', with: '環境構築 編集後'
        fill_in '自己PR', with: 'すぐに順応できるプログラム力です。 編集後'
      end
      it { expect(page).to have_content 'イッケンメノジコショウカイ' }
      it { expect(page).to have_content '株式会社フジボウル 編集後' }
      it { expect(page).to have_content '1件目の自己紹介' }
      it { expect(page).to have_content '女性' }
      it { expect(page).to have_content '六町駅 編集後' }
      it { expect(page).to have_content '19歳' }
      it { expect(page).to have_content '2023-04-01' }
      it { expect(page).to have_content 'あり' }
      it { expect(page).to have_content '10年6ヶ月' }
      it { expect(page).to have_content 'プログラミング 編集後' }
      it { expect(page).to have_content 'PHP / JavaScript / MySQL / HTML 編集後' }
      it { expect(page).to have_content '環境構築 編集後' }
      it { expect(page).to have_content 'すぐに順応できるプログラム力です。 編集後' }
    end
  end

end