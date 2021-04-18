require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag) { create(:tag) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(tag).to be_valid
    end

    it "名前がなければ無効であること" do
      tag = build(:tag, tag_name: nil)
      tag.valid?
      expect(tag.errors[:tag_name]).to include("を入力してください")
    end

    it "名前が20文字以内であること" do
      tag = build(:tag, tag_name: "あ" * 21)
      tag.valid?
      expect(tag.errors[:tag_name]).to include("は20文字以内で入力してください")
    end
  end
end
