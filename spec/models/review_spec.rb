require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効なReviewの場合は保存されるか" do
      expect(FactoryBot.build(:review)).to be_valid
    end
  end
  describe 'バリデーションのテスト' do
    subject { review.valid? }

    let(:review) { build(:review) }

    context 'rateカラム' do
      it '空欄でないこと' do
        review.rate = ''
        is_expected.to eq false
      end
      it '数値が5以下であること' do
        review.rate = 5
        is_expected.to eq true
      end
      it '数値が5以下であること' do
        review.rate = 6
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Stageモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:stage).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
