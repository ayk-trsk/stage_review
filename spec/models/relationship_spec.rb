require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { create(:relationship) }
  describe 'モデルのテスト' do
    context "保存できる場合" do
      it "有効なrelationshipの場合は保存されるか" do
        expect(relationship).to be_valid
      end
    end

    context "保存できない場合" do
      it "follower_idがnilの場合は保存できない" do
        relationship.follower_id = nil
        relationship.valid?
        expect(relationship.errors[:follower_id])
      end

      it "following_idがnilの場合は保存できない" do
        relationship.followed_id = nil
        relationship.valid?
        expect(relationship.errors[:following_id])
      end
    end

    context "一意性の検証" do
      before do
        @relation = create(:relationship)
        @user1 = build(:relationship)
      end
      it "follower_idとfollowed_idの組み合わせは一意でなければ保存できない" do
        relation2 = build(:relationship, follower_id: @relation.follower_id, followed_id: @relation.followed_id)
        relation2.valid?
        expect(relation2.errors[:follower_id])
      end

      it "follower_idが同じでもfollowing_idが違うなら保存できる" do
        relation2 = build(:relationship, follower_id: @relation.follower_id, followed_id: @user1.followed_id)
        expect(relation2).to be_valid
      end

      it "follower_idが違うならfollowing_idが同じでも保存できる" do
        relation2 = build(:relationship, follower_id: @user1.follower_id, followed_id: @relation.followed_id)
        expect(relation2).to be_valid
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "仮想モデルfollowerとのアソシエーション" do
      let(:target) { :follower }

      it "Followerとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "仮想モデルfollowingとのアソシエーション" do
      let(:target) { :followed }

      it "Followedとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end