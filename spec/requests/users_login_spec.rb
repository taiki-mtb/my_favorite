require 'rails_helper'

RSpec.describe "ログイン", type: :request do
  let!(:user) { create(:user) } 

  it "正常なレスポンスを返すこと" do
    get login_path
    expect(response).to be_successful
    expect(response).to have_http_status "200"
  end

  it "有効なユーザーでログインとログアウト" do
    get login_path
    post login_path, params: { session: { name: user.name,
                                          password: user.password } }
    redirect_to root_url
    follow_redirect!
    expect(response).to render_template('top_pages/top')
    expect(is_logged_in?).to be_truthy
    delete logout_path
    expect(is_logged_in?).not_to be_truthy
    redirect_to root_url
  end

  it "無効なユーザーでログイン" do
    get login_path
    post login_path, params: { session: { name: "hoge",
                                         password: user.password } }
    expect(is_logged_in?).not_to be_truthy
  end

end
