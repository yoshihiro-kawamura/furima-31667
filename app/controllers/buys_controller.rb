class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # 1つにまとめてあげる可読性を高めるために
  before_action :set_item, only: [:index, :create]

  def index
    @item_destination = ItemDestination.new
    # ログインユーザーとItem出品者が同じならroot_pathへ遷移する。
    # または、Itemがbuyにいればroot pathへ遷移される（つまり、購入されている商品の購入ページに遷移しようとするとroot pathへ遷移されるという意味）
    redirect_to root_path if @item.user == current_user || !@item.buy.nil?
  end

  def create
    @item_destination = ItemDestination.new(destination_params)
    if @item_destination.valid?
      pay_item
      # このsaveは通常のsaveとは違い、保存じゃなくてformオブジェクトのsaveに遷移する
      @item_destination.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def destination_params
    # permitはそのまま全て送られ、mergeの左側の値がフォームオブジェクトに送られている
    params.require(:item_destination).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    # ↓ここでPAY.jpに送られている
    Payjp::Charge.create(
      # これが使用できるのは、set_itemで@itemにデータを取って来ているため使える。
      amount: @item.price, # 商品の値段
      # 色々な表現方法があるが、今回は、destination_paramsにbinding.pryをかけてその中にtokenがあったので、そこから取得してきた。
      card: destination_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
