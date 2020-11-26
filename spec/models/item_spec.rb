require 'rails_helper'
describe User do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '画像つき投稿' do
    context '投稿がうまくいくとき' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '投稿がうまくいかないとき' do
      it '商品画像が空だと登録できない' do
        # この際画像を配置する時画像は中身が入っていないとだめ！
        # 空を表現する際に数値・画像なら「nil」、文字なら「””」にする。
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品説明が空だと登録できない' do
        @item.example = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it 'カテゴリーが空だと登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it '商品の状態が空だと登録できない' do
        @item.item_condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品状態を入力してください")
      end
      it '配送料の負担が空だと登録できない' do
        @item.shipping_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '発送元地域が空だと登録できない' do
        @item.area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("都道府県を入力してください")
      end
      it '発送までの日数が空だと登録できない' do
        @item.day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配達までの日数を入力してください")
      end
      it '金額が空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'カテゴリーの番号1番だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end
      it '商品の状態の番号1番だと登録できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品状態を入力してください')
      end
      it '配送料の負担の番号1番だと登録できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end
      it '発送元地域の番号1番だと登録できない' do
        @item.area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('都道府県を入力してください')
      end
      it '発送までの日数の番号1番だと登録できない' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配達までの日数を入力してください')
      end
      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
      it '金額が300円以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が正しくありません')
      end
      it '金額が半角数字でないと登録できない' do
        @item.price = 'あああ'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格が正しくありません')
      end
    end
  end
end
