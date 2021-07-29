require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効なContactの場合は保存されるか" do
      expect(FactoryBot.build(:contact)).to be_valid
    end
  end
  describe 'バリデーションのテスト' do
    subject { contact.valid? }

    let(:contact) { build(:contact) }

    context 'emailカラム' do
      it '空欄でないこと' do
        contact.email = ''
        is_expected.to eq false
      end
    end

    context 'subjectカラム' do
      it '空欄でないこと' do
        contact.subject = ''
        is_expected.to eq false
      end
    end

    context 'messageカラム' do
      it '空欄でないこと' do
        contact.message = ''
        is_expected.to eq false
      end
    end
  end
end
