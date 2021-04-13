RSpec.describe "音楽の削除", type: :request do
  let!(:user) { create(:user) }
  let!(:music) { create(:music) }

  it "処理が成功し、トップページにリダイレクトすること" do
    login_for_request(user)
    expect {
      delete music_path(music)
    }.to change(Music, :count).by(-1)
    redirect_to root_url
    follow_redirect!
    expect(response).to render_template('top_pages/top')
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete music_path(music)
      }.not_to change(Music, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
    end
  end
end