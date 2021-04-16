require 'rails_helper'

RSpec.describe Music, type: :model do
  let!(:music) { create(:music) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(music).to be_valid
    end

    it "名前がなければ無効であること" do
      music = build(:music, name: nil)
      music.valid?
      expect(music.errors[:name]).to include("を入力してください")
    end

    it "名前が50文字以内であること" do
      music = build(:music, name: "あ" * 51)
      music.valid?
      expect(music.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "説明が200文字以内であること" do
      music = build(:music, info: "あ" * 201)
      music.valid?
      expect(music.errors[:info]).to include("は200文字以内で入力してください")
    end

    it "youtube_urlがなければ無効であること" do
      music = build(:music, youtube_url: nil)
      music.valid?
      expect(music.errors[:youtube_url]).to include("を入力してください")
    end
  end
end
