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
  let!(:work_experience_a) {
    FactoryBot.create(:work_experience,
    introduction: introduction_a,
    start_month: '2020-12-01',
    end_month: '2023-03-01',
    project_name: 'ECサイト開発・リニューアル',
    project_detail: '機能追加',
    role: 15,
    role_description: 'SE: 1人 PG:2～5人',
    language: 'Ruby',
    database: 'PostgreSQL',
    server: 'AWS',
    fw_mw_tool_etc: 'Ruby on Rails',
    responsible_process: '実装'
    )
  }
  let(:work_experience_b) {
    FactoryBot.create(:work_experience,
    introduction: introduction_a,
    start_month: '2019-12-01',
    end_month: '2020-11-30',
    project_name: '不動産会社向けBtoBシステム開発',
    project_detail: 'インシデント対応',
    role: 14,
    role_description: 'バックエンド: 7人',
    language: 'Java',
    database: 'Oracle',
    server: 'Glassfish',
    fw_mw_tool_etc: 'Spring Boot',
    responsible_process: '詳細設計'
    )
  }

  ################################
  # 共通期待値
  ################################
  shared_examples_for '自己紹介Aの職務経歴aが表示されること' do
    it {
      expect(page).to have_content '2020-12-01'
      expect(page).to have_content '2023-03-01'
      expect(page).to have_content 'ECサイト開発・リニューアル'
      expect(page).to have_content '機能追加'
      expect(page).to have_content 'PM/PL/SE/PG'
      expect(page).to have_content 'SE: 1人 PG:2～5人'
      expect(page).to have_content 'Ruby'
      expect(page).to have_content 'PostgreSQL'
      expect(page).to have_content 'AWS'
      expect(page).to have_content 'Ruby on Rails'
      expect(page).to have_content '実装'
    }
  end

  shared_examples_for '自己紹介Aの職務経歴bが表示されること' do
    it {
      expect(page).to have_content '2019-12-01'
      expect(page).to have_content '2020-11-30'
      expect(page).to have_content '不動産会社向けBtoBシステム開発'
      expect(page).to have_content 'インシデント対応'
      expect(page).to have_content 'PM/PL/SE'
      expect(page).to have_content 'バックエンド: 7人'
      expect(page).to have_content 'Java'
      expect(page).to have_content 'Oracle'
      expect(page).to have_content 'Glassfish'
      expect(page).to have_content 'Spring Boot'
      expect(page).to have_content '詳細設計'
    }
  end

  ################################
  # 職務経歴書 表示
  ################################
  describe '職務経歴 基本情報の表示' do
    context '自己紹介一覧画面から遷移した時' do
      before do
        work_experience_b
        visit basic_work_experience_path(basic_work_experience_a)
      end
      it_behaves_like '自己紹介Aの職務経歴aが表示されること'
      it_behaves_like '自己紹介Aの職務経歴bが表示されること'
    end
  end

  ################################
  # 職務経歴書 職務経歴編集機能
  ################################
  describe '職務経歴 職務経歴編集機能' do
    let(:work_experience_project_name) {'ECサイト開発・リニューアル 編集後'}
    before do
      visit basic_work_experience_path(basic_work_experience_a)
      # find(:ypath, "職務経歴を編集するボタンの ypath").hover.click
      execute_script('window.scrollBy(10000,0)')
      click_on '職務経歴を編集する'
    end

    context '保存して戻るを押したとき' do
      before do
        fill_in '業務名', with: work_experience_project_name
        click_on '保存して戻る'
      end
      it '正常に更新されること' do
        expect(page).to have_content 'ECサイト開発・リニューアル 編集後'
      end
    end
  end
end