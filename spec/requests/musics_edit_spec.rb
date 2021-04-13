require "rails_helper"

RSpec.describe "音楽編集", type: :request do
  let!(:user) { create(:user) }
  let!(:music) { create(:music) }

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
    it "ログイン画面にリダイレクトすること" do
      get new_music_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end