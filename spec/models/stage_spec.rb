require 'rails_helper'

RSpec.describe 'Stageモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効なStageの場合は保存されるか" do
      expect(FactoryBot.build(:stage)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { stage.valid? }
    let!(:other_stage) { create(:stage) }
    let(:stage) { build(:stage) }

    context 'nameカラム' do
      it '空欄でないこと' do
        stage.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        stage.name = other_stage.name
        is_expected.to eq false
      end
    end

    context 'genreカラム' do
      it '空欄でないこと' do
        stage.genre_id = ''
        is_expected.to eq false
      end
    end

    context 'start_dateカラム' do
      it '空欄でないこと' do
        stage.start_date = ''
        is_expected.to eq false
      end
    end

    context 'end_dateカラム' do
      it '空欄でないこと' do
        stage.end_date = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Stage.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(Stage.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
