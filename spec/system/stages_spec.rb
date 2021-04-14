require 'rails_helper'

RSpec.describe "Stages", type: :system do
  let!(:user) { create(:user) }
  let!(:stage) { create(:stage) }

  describe "舞台登録ページ" do
    before do
      login_for_system(user)
      visit new_stage_path
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('New_stage')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'Name'
        expect(page).to have_content 'Info'
        expect(page).to have_content 'From date'
        expect(page).to have_content 'Until date'
        expect(page).to have_content 'Place'
        expect(page).to have_content 'Image'
      end
    end

    context "舞台登録処理" do
      it "有効な情報で登録すると登録成功のフラッシュが表示されること" do
        fill_in "Name", with: "name"
        click_button "登録する"
        expect(page).to have_content "新しいstageが登録されました"
      end

      it "無効な情報で登録すると登録失敗のフラッシュが表示されること" do
        fill_in "Name", with: ""
        click_button "登録する"
        expect(page).to have_content "Nameを入力してください"
      end
    end
  end

  describe "舞台詳細ページ" do
    before do
      login_for_system(user)
      visit stage_path(stage)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{stage.name}")
      end

      it "舞台情報が表示されること" do
        expect(page).to have_content stage.name
        expect(page).to have_content stage.info
      end
    end

#    context "舞台の削除", js: true do
#      it "削除成功のフラッシュが表示されること" do
#        within find('.change-stage') do
#          click_on '削除'
#        end
#        page.driver.browser.switch_to.alert.accept
#        expect(page).to have_content 'stageが削除されました'
#      end
#    end
  end
end
