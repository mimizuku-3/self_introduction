require 'rails_helper'

describe '自己紹介管理機能', type: :system do
  let(:introduction_a) {
    FactoryBot.create(:introduction,
      name: '1件目の自己紹介',
      age: 19,
      address: '港区西麻布3丁目20−6 杉友ビル2F',
      sex: 1,
      prefecture_id: 13,
      content: '1件目の自己紹介です!!',
      created_at: '2023-01-29 00:00:00',
      updated_at: '2023-01-30 00:00:00'
    )
  }
  let(:introduction_b) {
    FactoryBot.create(:introduction,
      name: '2件目の自己紹介',
      age: 40,
      address: '浦安市舞浜1-1',
      sex: 0,
      prefecture_id: 12,
      content: '2件目の自己紹介です!!',
      created_at: '2023-01-01 00:00:00',
      updated_at: '2023-01-02 00:00:00'
    )
  }
  
  ################################
  # 共通テストケース
  ################################
  shared_examples_for '自己紹介Aの「名前」が表示されること' do
    it { expect(page).to have_content '1件目の自己紹介' }
  end
  
  shared_examples_for '自己紹介Aの「年齢」が表示されること' do
    it { expect(page).to have_content 19 }
  end
  
  shared_examples_for '自己紹介Aの「年齢」（String）が表示されること' do
    it { expect(page).to have_content "19" }
  end

  shared_examples_for '自己紹介Aの「性別」が表示されること' do
    it { expect(page).to have_content '女性' }
  end

  shared_examples_for '自己紹介Aの「住所」が表示されること' do
    it { expect(page).to have_content '東京都港区西麻布3丁目20−6 杉友ビル2F' }
  end

  shared_examples_for '自己紹介Aの「住所」（都道府県以降）が表示されること' do
    it { expect(page).to have_content '港区西麻布3丁目20−6 杉友ビル2F' }
  end

  shared_examples_for '自己紹介Aの「自己紹介」が表示されること' do
    it { expect(page).to have_content '1件目の自己紹介です!!' }
  end

  shared_examples_for '自己紹介Aの「登録日時」が表示されること' do
    it { expect(page).to have_content '2023-01-29 00:00:00' }
  end

  shared_examples_for '自己紹介Aの「更新日時」が表示されること' do
    it { expect(page).to have_content '2023-01-30 00:00:00' }
  end

  shared_examples_for '「編集」リンクが表示されること' do
    it { expect(page).to have_link "編集", href: edit_introduction_path(introduction_a) }
  end

  shared_examples_for '「削除」リンクが表示されること' do
    it { expect(page).to have_link "削除", href: introduction_path(introduction_a) }
  end

  shared_examples_for '自己紹介Bが検索結果に表示されないこと' do
    it {
      expect(page).to_not have_content '2件目の自己紹介'
      expect(page).to_not have_content 40
      expect(page).to_not have_content '千葉県浦安市舞浜1-1'
      expect(page).to_not have_content '2023-01-01 00:00:00'
      expect(page).to_not have_content '2023-01-02 00:00:00'
    }
  end
  
  ################################
  # 一覧画面
  ################################
  describe '一覧表示機能' do
    before do
    end

    context '一覧画面に遷移したとき' do
      before do
        introduction_a
        # FactoryBot.create(:hobby_introduction, introduction: introduction_a, hobby_id: 2)
        visit introductions_path
      end
      
      it_behaves_like '自己紹介Aの「名前」が表示されること'
      it_behaves_like '自己紹介Aの「年齢」が表示されること'
      it_behaves_like '自己紹介Aの「性別」が表示されること'
      it_behaves_like '自己紹介Aの「住所」が表示されること'
      it_behaves_like '自己紹介Aの「登録日時」が表示されること'
      it_behaves_like '自己紹介Aの「更新日時」が表示されること'

      # it '趣味が表示されること' do
      #   expect(page).to have_content '読書'
      # end
    end

    context '自己紹介が2件以上登録されているときの一覧画面' do
      # Todo: 登録画面から登録した2件目の自己紹介が表示されることの確認にする。
      before do
        introduction_a
        introduction_b
        visit introductions_path
      end
      it '自己紹介2件分が表示されていること' do
        # 自己紹介A
        expect(page).to have_content '1件目の自己紹介'
        expect(page).to have_content 19
        expect(page).to have_content '東京都港区西麻布3丁目20−6 杉友ビル2F'
        expect(page).to have_content '女性'
        expect(page).to have_content '2023-01-29 00:00:00'
        expect(page).to have_content '2023-01-30 00:00:00'
        
        # 自己紹介B
        expect(page).to have_content '2件目の自己紹介'
        expect(page).to have_content 40
        expect(page).to have_content '千葉県浦安市舞浜1-1'
        expect(page).to have_content '男性'
        expect(page).to have_content '2023-01-01 00:00:00'
        expect(page).to have_content '2023-01-02 00:00:00'
      end
    end

    context '一覧画面の全体確認' do
      before do
        introduction_a
        visit introductions_path
      end

      it '「検索」ボタンが表示されること'  do
        expect(page).to have_button "検索"
      end

      it '「リセット」ボタンが表示されること'  do
        expect(page).to have_button "リセット"
      end

      it '「新規登録」リンクが表示されること'  do
        expect(page).to have_link "新規登録", href: new_introduction_path
      end

      it '「詳細」リンクが表示されること'  do
        expect(page).to have_link "詳細", href: introduction_path(introduction_a)
      end

      it_behaves_like '「編集」リンクが表示されること'
      it_behaves_like '「削除」リンクが表示されること'

    end
  end


  ################################
  # 詳細画面
  ################################
  describe '詳細表示機能' do
    context '詳細画面に遷移した時'  do
      before do
        visit introduction_path(introduction_a)
      end

      it_behaves_like '自己紹介Aの「名前」が表示されること'
      it_behaves_like '自己紹介Aの「年齢」が表示されること'
      it_behaves_like '自己紹介Aの「性別」が表示されること'
      it_behaves_like '自己紹介Aの「住所」が表示されること'
      it_behaves_like '自己紹介Aの「登録日時」が表示されること'
      it_behaves_like '自己紹介Aの「更新日時」が表示されること'
      it_behaves_like '自己紹介Aの「自己紹介」が表示されること'

      it_behaves_like '「編集」リンクが表示されること'
      it_behaves_like '「削除」リンクが表示されること'

    end
  end

  ################################
  # 新規登録機能
  ################################
  describe '新規登録機能' do
    let(:introduction_name) {'3件目の自己紹介'}
    let(:introduction_age) {40}
    let(:introduction_sex) {0}
    let(:introduction_prefecture_id) {1}
    let(:introduction_address) {'札幌市豊平区羊ケ丘１'}
    let(:introduction_content) {'3件目の自己紹介です!!'}
  
    # ---------------------------
    # 新規登録（入力）画面
    # ---------------------------
    describe '新規登録（入力）画面' do
      before do
        visit new_introduction_path
        fill_in '名前', with: introduction_name
        fill_in '年齢', with: introduction_age
        fill_in '住所', with: introduction_address
        fill_in '自己紹介', with: introduction_content
      end
      
      context '全項目を入力したとき' do
        before do
          choose '男性'
          select '北海道', from: 'introduction_prefecture_id'
          click_button '確認'
        end
  
        it '新規登録（確認）画面に遷移すること' do
          expect(current_path).to eq confirm_new_introduction_path
        end
        # it_behaves_like '新規登録（確認）画面に入力した値が表示されること'
        it '入力した値が表示されること' do
          expect(page).to have_content '3件目の自己紹介'
          expect(page).to have_content 40
          expect(page).to have_content '男性'
          expect(page).to have_content '北海道'
          expect(page).to have_content '札幌市豊平区羊ケ丘１'
          expect(page).to have_content '3件目の自己紹介です!!'
        end
      end
  
      context '必須項目を入力しなかったとき' do
        let(:introduction_name) {''}
        let(:introduction_age) {''}
        let(:introduction_address) {''}
  
        before do
          click_button '確認'
        end
  
        it 'バリデーションエラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名前を入力してください'
            expect(page).to have_content '年齢を入力してください'
            expect(page).to have_content '性別を入力してください'
            expect(page).to have_content '住所を入力してください'
            expect(page).to have_content 'Prefectureを入力してください'
          end
        end
      end
  
      context '「リセット」ボタンを押下したとき' do
        it '入力値が空になる' do
        end
      end
    end
  
    #---------------------------
    # 新規登録（確認）画面
    #---------------------------
    describe '新規登録（確認）画面' do
      before do
        visit new_introduction_path
        fill_in '名前', with: introduction_name
        fill_in '年齢', with: introduction_age
        fill_in '住所', with: introduction_address
        fill_in '自己紹介', with: introduction_content
        choose '男性'
        select '北海道', from: 'introduction_prefecture_id'
        click_button '確認'
      end
      
      context '「登録」ボタンを押下したとき' do
        before do
          click_button '登録'
        end
        it '正常に登録できること' do
          expect(current_path).to eq complete_introductions_path
        end
  
        it '「一覧」リンクが表示されること' do
          expect(page).to have_link "一覧", href: introductions_path
        end
      end
  
      #Todo  「戻る」ボタンを押下した時
      
    end
  end


  describe '編集機能' do
    describe '編集（入力）画面' do
      before do
        visit edit_introduction_path(introduction_a)
      end

      context '自己紹介Aの編集画面に遷移した時' do
        # it_behaves_like '自己紹介Aの「名前」が表示されること'
        # it_behaves_like '自己紹介Aの「年齢」（String）が表示されること'
        # it_behaves_like '自己紹介Aの「性別」が表示されること'
        # it_behaves_like '自己紹介Aの「住所」（都道府県以降）が表示されること'
        # it_behaves_like '自己紹介Aの「自己紹介」が表示されること'
      end

      context '全項目を入力したとき' do
        let(:introduction_name) {'1件目の自己紹介の編集後'}
        let(:introduction_age) {21}
        let(:introduction_address) {'港区西麻布3丁目20−6 杉友ビル2F（編集後）'}
        let(:introduction_content) {'自己紹介Aの編集後です。'}
        
        before do
          fill_in '名前', with: introduction_name
          fill_in '年齢', with: introduction_age
          fill_in '住所', with: introduction_address
          fill_in '自己紹介', with: introduction_content
          choose '男性'
          select '愛媛県', from: 'introduction_prefecture_id'
          click_button '確認'
        end

        it '編集（確認）画面に遷移し、入力した値が表示されること' do
          expect(current_path).to eq confirm_introduction_path(introduction_a)
          expect(page).to have_content '1件目の自己紹介の編集後'
          expect(page).to have_content 21
          expect(page).to have_content '男性'
          expect(page).to have_content '愛媛県'
          expect(page).to have_content '港区西麻布3丁目20−6 杉友ビル2F（編集後）'
          expect(page).to have_content '自己紹介Aの編集後です。'
        end
      end

      context '必須項目を入力しなかったとき' do
        let(:introduction_name) {''}
        let(:introduction_age) {''}
        let(:introduction_address) {''}
        before do
          fill_in '名前', with: introduction_name
          fill_in '年齢', with: introduction_age
          fill_in '住所', with: introduction_address
          select '---', from: 'introduction_prefecture_id'
          click_button '確認'
        end
        it 'バリデーションエラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名前を入力してください'
            expect(page).to have_content '年齢を入力してください'
            expect(page).to have_content '住所を入力してください'
            expect(page).to have_content 'Prefectureを入力してください'
          end
        end
      end
    end

    #---------------------------
    # 編集（確認）画面
    #---------------------------
    # describe '編集（確認）画面' do
    #   before do
    #     visit edit_introduction_path(introduction_a)
    #     fill_in '名前', with: introduction_name
    #     fill_in '年齢', with: introduction_age
    #     fill_in '住所', with: introduction_address
    #     fill_in '自己紹介', with: introduction_content
    #   end

    #   context '全項目を入力したとき' do
    #     let(:introduction_name) {'1件目の自己紹介の編集後'}
    #     let(:introduction_age) {21}
    #     let(:introduction_address) {'港区西麻布3丁目20−6 杉友ビル2F（編集後）'}
    #     let(:introduction_content) {'自己紹介Aの編集後です。'}
    #     before do
    #       choose '男性'
    #       select '愛媛県', from: 'introduction_prefecture_id'
    #       click_button '確認'
    #     end
    #     it '編集（確認）画面に遷移し、入力した値が表示されること' do
    #       expect(current_path).to eq confirm_introduction_path(introduction_a)
    #       expect(page).to have_content '1件目の自己紹介の編集後'
    #       expect(page).to have_content 21
    #       expect(page).to have_content '男性'
    #       expect(page).to have_content '愛媛県'
    #       expect(page).to have_content '港区西麻布3丁目20−6 杉友ビル2F（編集後）'
    #       expect(page).to have_content '自己紹介Aの編集後です。'
    #     end
    #   end

    #   context '必須項目を入力しなかったとき' do
    #     let(:introduction_name) {''}
    #     let(:introduction_age) {''}
    #     let(:introduction_address) {''}
    #     before do
    #       select '---', from: 'introduction_prefecture_id'
    #       click_button '確認'
    #     end
    #     it 'バリデーションエラーとなる' do
    #       within '#error_explanation' do
    #         expect(page).to have_content '名前を入力してください'
    #         expect(page).to have_content '年齢を入力してください'
    #         expect(page).to have_content '住所を入力してください'
    #         expect(page).to have_content 'Prefectureを入力してください'
    #       end
    #     end
    #   end
      
    #   context '「登録」ボタンを押下したとき' do
    #     before do
    #       choose '男性'
    #       select '愛媛県', from: 'introduction_prefecture_id'
    #       click_button '確認'
    #       click_button '登録'
    #     end
    #     it '正常に編集できること' do
    #       expect(current_path).to eq complete_introductions_path
    #     end
    #   end
  
    #   #Todo  「戻る」ボタンを押下した時
      
    # end
  end

  describe '検索機能' do
    before do
      introduction_a
      introduction_b
      visit introductions_path
      choose '女性'
      fill_in 'age_from', with: 18
      fill_in 'age_end', with: 20
      select '東京都', from: '住所（都道府県）'
    end

    context '自己紹介Aがヒットする項目を指定して検索をしたとき' do
      before do
        fill_in '名前', with: '1件目の自己紹介'
        click_button '検索'
      end
      it_behaves_like '自己紹介Aの「名前」が表示されること'
      it_behaves_like '自己紹介Aの「年齢」が表示されること'
      it_behaves_like '自己紹介Aの「住所」が表示されること'
      it_behaves_like '自己紹介Aの「登録日時」が表示されること'
      it_behaves_like '自己紹介Aの「更新日時」が表示されること'
      it_behaves_like '自己紹介Bが検索結果に表示されないこと'
    end

    context '自己紹介Aがヒットしない項目を指定して検索をしたとき' do
      before do
        fill_in '名前', with: 'hoge'
        click_button '検索'
      end
      it '自己紹介Aは表示されないこと' do
        expect(page).to_not have_content '1件目の自己紹介'
        expect(page).to_not have_content 19
        expect(page).to_not have_content '東京都港区西麻布3丁目20−6 杉友ビル2F'
        expect(page).to_not have_content '2023-01-29 00:00:00'
        expect(page).to_not have_content '2023-01-30 00:00:00'
      end
      it_behaves_like '自己紹介Bが検索結果に表示されないこと'
    end
  end
end