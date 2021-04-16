require 'rails_helper'

RSpec.describe Artist, type: :model do
  let!(:artist) { create(:artist) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(artist).to be_valid
    end

    it "名前がなければ無効であること" do
      artist = build(:artist, name: nil)
      artist.valid?
      expect(artist.errors[:name]).to include("を入力してください")
    end

    it "名前が20文字以内であること" do
      artist = build(:artist, name: "あ" * 21)
      artist.valid?
      expect(artist.errors[:name]).to include("は20文字以内で入力してください")
    end

    it "説明が200文字以内であること" do
      artist = build(:artist, info: "あ" * 201)
      artist.valid?
      expect(artist.errors[:info]).to include("は200文字以内で入力してください")
    end
  end
end
