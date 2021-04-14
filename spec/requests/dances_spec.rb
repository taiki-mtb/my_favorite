require "rails_helper"

RSpec.describe "ダンス登録", type: :request do
  let!(:user)  { create(:user) }
  let!(:dance) { create(:dance) }

  describe "ダンス登録ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_dance_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('dances/new')
      end

      it "登録後詳細ページに飛ぶこと" do
        expect {
          post dances_path, params: { dance: { name: "name",
                                               youtube_url: "#{"a" * 11}" } }
        }.to change(Dance, :count).by(1)
        follow_redirect!
        expect(response).to render_template('dances/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_dance_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "ダンス詳細ページ" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get dance_path(dance)
      expect(response).to have_http_status "200"
      expect(response).to render_template('dances/show')
    end
  end

  describe "ダンス編集ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_dance_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('dances/new')
      end

      it "編集後詳細ページに飛ぶこと" do
        patch dance_path(dance), params: { dance: { name: "name",
                                                    youtube_url: "#{"a" * 11}" } }
        redirect_to dance
        follow_redirect!
        expect(response).to render_template('dances/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_dance_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "ダンス削除" do
    context "ログインしている場合" do
      it "処理が成功し、トップページにリダイレクトすること" do
        login_for_request(user)
        expect {
          delete dance_path(dance)
        }.to change(Dance, :count).by(-1)
        redirect_to root_url
        follow_redirect!
        expect(response).to render_template('top_pages/top')
      end
    end

    context "ログインしていない場合" do
      it "トップページへリダイレクトすること" do
        expect {
          delete dance_path(dance)
        }.not_to change(Dance, :count)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end
end
