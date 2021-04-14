require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let!(:user) { create(:user) }

  before do
    visit login_path
  end

  describe "ログインページ" do
    context "ページレイアウト" do
      it "ログインフォームのラベルが正しく表示される" do
        expect(page).to have_content '名前'
        expect(page).to have_content 'パスワード'
      end

      it "ログインフォームが正しく表示される" do
        expect(page).to have_css 'input#user_name'
        expect(page).to have_css 'input#user_password'
      end

      it "ログインボタンが表示される" do
        expect(page).to have_button 'ログイン'
      end
    end

    context "ログイン処理" do
      it "無効なユーザーでログインを行うとログインが失敗することを確認" do
        fill_in "user_name", with: "hoge"
        fill_in "user_password", with: "password"
        click_button "ログイン"
        expect(page).to have_content '名前とパスワードの組み合わせが間違っています'

        visit root_path
        expect(page).not_to have_content "メールアドレスとパスワードの組み合わせが間違っています"
      end
    end
  end
end
