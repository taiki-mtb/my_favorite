require 'rails_helper'

RSpec.describe Music, type: :model do
  let!(:dance) { create(:dance) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(dance).to be_valid
    end

    it "名前がなければ無効であること" do
      dance = build(:dance, name: nil)
      dance.valid?
      expect(dance.errors[:name]).to include("を入力してください")
    end

    it "名前が100文字以内であること" do
      dance = build(:dance, name: "あ" * 101)
      dance.valid?
      expect(dance.errors[:name]).to include("は100文字以内で入力してください")
    end

    it "説明が200文字以内であること" do
      dance = build(:dance, info: "あ" * 201)
      dance.valid?
      expect(dance.errors[:info]).to include("は200文字以内で入力してください")
    end

    it "youtube_urlがなければ無効であること" do
      dance = build(:dance, youtube_url: nil)
      dance.valid?
      expect(dance.errors[:youtube_url]).to include("を入力してください")
    end
  end
end
