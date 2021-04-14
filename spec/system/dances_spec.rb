require 'rails_helper'

RSpec.describe "Dances", type: :system do
  let!(:user) { create(:user) }
  let!(:dance) { create(:dance) }

  describe "ダンス登録ページ" do
    before do
      login_for_system(user)
      visit new_dance_path
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('New_dance')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'Name'
        expect(page).to have_content 'Info'
        expect(page).to have_content 'Date'
        expect(page).to have_content 'Youtube url'
      end
    end

    context "ダンス登録処理" do
      it "有効な情報で登録すると登録成功のフラッシュが表示されること" do
        fill_in "Name", with: "name"
        fill_in "Youtube url", with: "#{"a" * 11}"
        click_button "登録する"
        expect(page).to have_content "新しいdanceが登録されました"
      end

      it "無効な情報で登録すると登録失敗のフラッシュが表示されること" do
        fill_in "Name", with: ""
        click_button "登録する"
        expect(page).to have_content "Nameを入力してください"
      end
    end
  end

  describe "ダンス詳細ページ" do
    before do
      login_for_system(user)
      visit dance_path(dance)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{dance.name}")
      end

      it "ダンス情報が表示されること" do
        expect(page).to have_content dance.name
        expect(page).to have_content dance.info
      end
    end

#    context "ダンスの削除", js: true do
#      it "削除成功のフラッシュが表示されること" do
#        within find('.change-dance') do
#          click_on '削除'
#        end
#        page.driver.browser.switch_to.alert.accept
#        expect(page).to have_content 'ダンスが削除されました'
#      end
#    end
  end
end
