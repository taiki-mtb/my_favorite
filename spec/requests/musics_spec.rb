require "rails_helper"

RSpec.describe "音楽登録", type: :request do
  let!(:user)  { create(:user) }
  let!(:music) { create(:music) }

  describe "音楽登録ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_music_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('musics/new')
      end

      it "登録後詳細ページに飛ぶこと" do
        expect {
          post musics_path, params: { music: { name: "name",
                                               youtube_url: "#{"a" * 11}" } }
        }.to change(Music, :count).by(1)
        follow_redirect!
        expect(response).to render_template('musics/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_music_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "音楽詳細ページ" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get music_path(music)
      expect(response).to have_http_status "200"
      expect(response).to render_template('musics/show')
    end
  end

  describe "音楽編集ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_music_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('musics/new')
      end

      it "編集後詳細ページに飛ぶこと" do
        patch music_path(music), params: { music: { name: "name",
                                               youtube_url: "#{"a" * 11}" } }
        redirect_to music
        follow_redirect!
        expect(response).to render_template('musics/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_music_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "音楽削除" do
    context "ログインしている場合" do
      it "処理が成功し、トップページにリダイレクトすること" do
        login_for_request(user)
        expect {
          delete music_path(music)
        }.to change(Music, :count).by(-1)
        redirect_to root_url
        follow_redirect!
        expect(response).to render_template('top_pages/top')
      end
    end

    context "ログインしていない場合" do
      it "トップページへリダイレクトすること" do
        expect {
          delete music_path(music)
        }.not_to change(Music, :count)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end
end
