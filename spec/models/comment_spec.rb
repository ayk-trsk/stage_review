require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効なCommentの場合は保存されるか" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
  end
  describe 'バリデーションのテスト' do
    subject { comment.valid? }

    let(:comment) { build(:comment) }

    context 'contentカラム' do
      it '空欄でないこと' do
        comment.content = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Reviewモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:review).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
