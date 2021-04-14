require "rails_helper"

RSpec.describe "舞台登録", type: :request do
  let!(:user)  { create(:user) }
  let!(:stage) { create(:stage) }

  describe "舞台登録ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_stage_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('stages/new')
      end

      it "登録後詳細ページに飛ぶこと" do
        expect {
          post stages_path, params: { stage: { name: "name" } }
        }.to change(Stage, :count).by(1)
        follow_redirect!
        expect(response).to render_template('stages/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_stage_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "舞台詳細ページ" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get stage_path(stage)
      expect(response).to have_http_status "200"
      expect(response).to render_template('stages/show')
    end
  end

  describe "舞台編集ページ" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
        get new_stage_path
      end

      it "レスポンスが正常に表示されること" do
        expect(response).to render_template('stages/new')
      end

      it "編集後詳細ページに飛ぶこと" do
        patch stage_path(stage), params: { stage: { name: "name" } }
        redirect_to stage
        follow_redirect!
        expect(response).to render_template('stages/show')
      end
    end

    context "ログインしていない場合" do
      it "トップページにリダイレクトすること" do
        get new_stage_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "舞台削除" do
    context "ログインしている場合" do
      it "処理が成功し、トップページにリダイレクトすること" do
        login_for_request(user)
        expect {
          delete stage_path(stage)
        }.to change(Stage, :count).by(-1)
        redirect_to root_url
        follow_redirect!
        expect(response).to render_template('top_pages/top')
      end
    end

    context "ログインしていない場合" do
      it "トップページへリダイレクトすること" do
        expect {
          delete stage_path(stage)
        }.not_to change(Stage, :count)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end
end
