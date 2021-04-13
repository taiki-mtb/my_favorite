require "rails_helper"

RSpec.describe "音楽詳細ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:music) { create(:music) }

  it "レスポンスが正常に表示されること" do
    login_for_request(user)
    get music_path(music)
    expect(response).to have_http_status "200"
    expect(response).to render_template('musics/show')
  end
end