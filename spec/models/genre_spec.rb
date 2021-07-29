require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効なGenreの場合は保存されるか" do
      expect(FactoryBot.build(:genre)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    let!(:other_genre) { create(:genre) }
    let(:genre) { build(:genre) }

    context 'nameカラム' do
      it '空欄でないこと' do
        genre.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        genre.name = other_genre.name
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Stageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:stages).macro).to eq :has_many
      end
    end
  end
end
