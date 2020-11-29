require 'rails_helper'
describe User do
  before do
    @item_destination = FactoryBot.build(:item_destination)
  end

  describe '購入情報の入力' do
    context '購入がうまくいくとき' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@item_destination).to be_valid
      end
      it '建物名がなくても購入できる' do
        @item_destination.building_name = ''
        expect(@item_destination).to be_valid
      end
    end
    # テストコードはmodelのValidation、class等に対してテストしている。
    # 〜が存在しない等の文は（nil）か（""）を使うと良い
    context '購入がうまくいかないとき' do
      it '郵便番号が空だと登録できない' do
        @item_destination.postal_code = nil
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '都道府県が空だと登録できない' do
        @item_destination.prefecture_id = ''
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('都道府県を入力してください')
      end
      it '市町村が空だと登録できない' do
        @item_destination.city = ''
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('市町村を入力してください')
      end
      it '番地が空だと登録できない' do
        @item_destination.house_number = nil
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が空だと登録できない' do
        @item_destination.phone_number = nil
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('電話番号を入力してください')
      end
      it '郵便番号が半角数字・ハイフンどちらとも満たしていないと登録できない' do
        @item_destination.postal_code = 1_111_111
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '都道府県の番号が0番だと登録できない' do
        @item_destination.prefecture_id = 0
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('都道府県を入力してください')
      end
      it '電話番号は半角数字・11文字でないと登録できない' do
        @item_destination.phone_number = 123_456_789_123
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'トークンが空ではないこと' do
        @item_destination.token = nil
        @item_destination.valid?
        expect(@item_destination.errors.full_messages).to include('トークンを入力してください')
      end
    end
  end
end
