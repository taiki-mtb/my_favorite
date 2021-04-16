require 'rails_helper'

RSpec.describe "Artist", type: :system do
  let!(:user) { create(:user) }
  let!(:artist) { create(:artist) }

  describe "アーティスト登録ページ" do
    before do
      login_for_system(user)
      visit new_artist_path
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('New_artist')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'Name'
        expect(page).to have_content 'Info'
        expect(page).to have_content 'Image'
      end
    end

    context "アーティスト登録処理" do
      it "有効な情報で登録すると登録成功のフラッシュが表示されること" do
        fill_in "Name", with: "name"
        click_button "登録する"
        expect(page).to have_content "新しいartistが登録されました"
      end

      it "無効な情報で登録すると登録失敗のフラッシュが表示されること" do
        fill_in "Name", with: ""
        click_button "登録する"
        expect(page).to have_content "Nameを入力してください"
      end
    end
  end

  describe "アーティスト詳細ページ" do
    before do
      login_for_system(user)
      visit artist_path(artist)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{artist.name}")
      end

      it "アーティスト情報が表示されること" do
        expect(page).to have_content artist.name
        expect(page).to have_content artist.info
      end
    end

# context "アーティストの削除", js: true do
#   it "削除成功のフラッシュが表示されること" do
#     within find('.change-artist') do
#       click_on '削除'
#     end
#     page.driver.browser.switch_to.alert.accept
#     expect(page).to have_content 'artistが削除されました'
#   end
# end
  end
end
