require "rails_helper"

RSpec.describe "アーティスト登録", type: :request do
  let!(:user)  { create(:user) }
  let!(:artist) { create(:artist) }

  describe "アーティスト登録ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_artist_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('artists/new')
      end

      it "登録後詳細ページに飛ぶこと" do
        expect {
          post artists_path, params: { artist: { name: "name" } }
        }.to change(Artist, :count).by(1)
        follow_redirect!
        expect(response).to render_template('artists/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_artist_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "アーティスト詳細ページ" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get artist_path(artist)
      expect(response).to have_http_status "200"
      expect(response).to render_template('artists/show')
    end
  end

  describe "アーティスト編集ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_artist_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('artists/new')
      end

      it "編集後詳細ページに飛ぶこと" do
        patch artist_path(artist), params: { artist: { name: "name" } }
        redirect_to artist
        follow_redirect!
        expect(response).to render_template('artists/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_artist_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "アーティスト削除" do
    context "ログインしている場合" do
      it "処理が成功し、トップページにリダイレクトすること" do
        login_for_request(user)
        expect {
          delete artist_path(artist)
        }.to change(Artist, :count).by(-1)
        redirect_to root_url
        follow_redirect!
        expect(response).to render_template('top_pages/top')
      end
    end

    context "ログインしていない場合" do
      it "トップページへリダイレクトすること" do
        expect {
          delete artist_path(artist)
        }.not_to change(Artist, :count)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end
end
