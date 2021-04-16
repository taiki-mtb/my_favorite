require 'rails_helper'

RSpec.describe Stage, type: :model do
  let!(:stage) { create(:stage) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(stage).to be_valid
    end

    it "名前がなければ無効であること" do
      stage = build(:stage, name: nil)
      stage.valid?
      expect(stage.errors[:name]).to include("を入力してください")
    end

    it "名前が50文字以内であること" do
      stage = build(:stage, name: "あ" * 51)
      stage.valid?
      expect(stage.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "説明が500文字以内であること" do
      stage = build(:stage, info: "あ" * 501)
      stage.valid?
      expect(stage.errors[:info]).to include("は500文字以内で入力してください")
    end
  end
end
