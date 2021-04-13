require 'rails_helper'

RSpec.describe "Musics", type: :system do
  let!(:user) { create(:user) }
  let!(:music) { create(:music) }


  describe "音楽登録ページ" do
    before do
      login_for_system(user)
      visit new_music_path
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('New_music')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'Name'
        expect(page).to have_content 'Info'
        expect(page).to have_content 'Date'
        expect(page).to have_content 'Youtube url'
      end
    end

    context "音楽登録処理" do
      it "有効な情報で登録すると登録成功のフラッシュが表示されること" do
        fill_in "Name", with: "name"
        fill_in "Youtube url", with: "#{"a" * 11}"
        click_button "登録する"
        expect(page).to have_content "新しいmusicが登録されました"
      end

      it "無効な情報で登録すると登録失敗のフラッシュが表示されること" do
        fill_in "Name", with: ""
        click_button "登録する"
        expect(page).to have_content "Nameを入力してください"
      end
    end
  end

  describe "音楽詳細ページ" do
    before do
      login_for_system(user)
      visit music_path(music)
    end

    context "ページレイアウト" do

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{music.name}")
      end

      it "音楽情報が表示されること" do
        expect(page).to have_content music.name
        expect(page).to have_content music.info
      end
    end

#    context "音楽の削除", js: true do
#      it "削除成功のフラッシュが表示されること" do
#        within find('.change-music') do
#          click_on '削除'
#        end
#        page.driver.browser.switch_to.alert.accept
#        expect(page).to have_content 'musicが削除されました'
#      end
#    end
  end
end