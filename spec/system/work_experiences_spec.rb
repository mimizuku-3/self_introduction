require 'rails_helper'

describe '職務経歴書管理機能', type: :system do
  let!(:introduction_a) {
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
  let(:discarded_work_experience) {
    FactoryBot.create(:work_experience,
      introduction: introduction_a,
      project_name: '削除済み職務経歴',
      discarded_at: '2023-02-17 00:00:00'
    )
  }

  ################################
  # 共通期待値
  ################################
  shared_examples_for '自己紹介Aの職務経歴aが表示されること' do
    it {
      expect(page).to have_content '2020年12月'
      expect(page).to have_content '2023年03月'
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
      expect(page).to have_content '2019年12月'
      expect(page).to have_content '2020年11月'
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
      it '削除済みの職務経歴が表示されないこと' do
        expect(page).to_not have_content '削除済み職務経歴'
      end
    end
  end

  ################################
  # 職務経歴書 職務経歴編集機能
  ################################
  describe '職務経歴 編集・登録機能' do
    let(:project_name) {'ECサイト開発・リニューアル 編集後'}
    let(:project_detail) {'機能追加 編集後'}
    let(:role_description) {'SE: 1人 PG:2～5人 編集後'}
    let(:language) {'Ruby 編集後'}
    let(:database) {'PostgreSQL 編集後'}
    let(:server) {'AWS 編集後'}
    let(:fw_mw_tool_etc) {'Ruby on Rails 編集後'}
    let(:responsible_process) {'実装 編集後'}

    describe '職務経歴 編集機能' do
      before do
        visit edit_work_experience_path(work_experience_a)
      end

      context '保存して戻るを押したとき' do
        before do
          select '2021', from: 'work_experience_start_month_1i'
          select '12月', from: 'work_experience_start_month_2i'
          select '2024', from: 'work_experience_end_month_1i'
          select '3月', from: 'work_experience_end_month_2i'
          fill_in '業務名', with: project_name
          fill_in '業務詳細', with: project_detail
          check 'PL'
          fill_in '役割詳細', with: role_description
          fill_in '使用言語', with: language
          fill_in 'DB', with: database
          fill_in 'サーバー', with: server
          fill_in 'FW・MWツール等', with: fw_mw_tool_etc
          fill_in '担当工程', with: responsible_process
          click_on '保存して戻る'
        end
        it '正常に更新されること' do
          expect(page).to have_content '2021年12月'
          expect(page).to have_content '2024年03月'
          expect(page).to have_content 'ECサイト開発・リニューアル 編集後'
          expect(page).to have_content '機能追加 編集後'
          expect(page).to have_content 'PL'
          expect(page).to have_content 'SE: 1人 PG:2～5人 編集後'
          expect(page).to have_content 'Ruby 編集後'
          expect(page).to have_content 'PostgreSQL 編集後'
          expect(page).to have_content 'AWS 編集後'
          expect(page).to have_content 'Ruby on Rails 編集後'
          expect(page).to have_content '実装 編集後'
        end
      end

      context '削除済みの職務経歴の編集画面をURLから直接開く時' do
        before do
          visit "/work_experiences/#{discarded_work_experience.id}"
        end
        it 'エラーメッセージが表示される' do
          expect(page).to have_current_path "/"
          expect(page).to have_content '存在しない職務経歴です。'
        end
      end

      # context '最大文字数を超過したとき' do
      #   let(:project_name) {'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRS'}
      #   before do
      #     fill_in '業務名', with: project_name
      #     click_on '保存して戻る'
      #   end
      #   it 'バリデーションエラーメッセージが表示される' do
      #     expect(page).to have_content '業務名は200文字以内で入力してください'
      #   end
      # end
    end

    ################################
    # 職務経歴書 職務経歴登録機能
    ################################
    describe '職務経歴 職務経歴登録機能' do
      before do
        visit "/introductions/#{introduction_a.id}/work_experiences/new"
      end

      context '保存して戻るを押したとき' do
        before do
          select '2021', from: 'work_experience_start_month_1i'
          select '12月', from: 'work_experience_start_month_2i'
          select '2024', from: 'work_experience_end_month_1i'
          select '3月', from: 'work_experience_end_month_2i'
          fill_in '業務名', with: project_name
          fill_in '業務詳細', with: project_detail
          check 'PL'
          fill_in '役割詳細', with: role_description
          fill_in '使用言語', with: language
          fill_in 'DB', with: database
          fill_in 'サーバー', with: server
          fill_in 'FW・MWツール等', with: fw_mw_tool_etc
          fill_in '担当工程', with: responsible_process
          click_on '保存して戻る'
        end
        it '正常に登録されること' do
          expect(page).to have_content '2021年12月'
          expect(page).to have_content '2024年03月'
          expect(page).to have_content 'ECサイト開発・リニューアル 編集後'
          expect(page).to have_content '機能追加 編集後'
          expect(page).to have_content 'PL'
          expect(page).to have_content 'SE: 1人 PG:2～5人 編集後'
          expect(page).to have_content 'Ruby 編集後'
          expect(page).to have_content 'PostgreSQL 編集後'
          expect(page).to have_content 'AWS 編集後'
          expect(page).to have_content 'Ruby on Rails 編集後'
          expect(page).to have_content '実装 編集後'
        end
      end

      # context '最大文字数を超過したとき' do
      #   let(:project_name) {'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRS'}
      #   before do
      #     fill_in '業務名', with: project_name
      #     click_on '保存して戻る'
      #   end
      #   it 'バリデーションエラーメッセージが表示される' do
      #     expect(page).to have_content '業務名は200文字以内で入力してください'
      #   end
      # end
    end
  end
end