require 'rails_helper'

describe '自己紹介管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:introduction, name: '最初の自己紹介')
    end

    context '自己紹介一覧が表示されることの確認' do
      before do
        visit introductions_path
      end

      it '自己紹介一覧が表示される' do
        expect(page).to have_content '最初の自己紹介'
      end
    end
  end
end