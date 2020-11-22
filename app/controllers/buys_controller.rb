class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]

  def index
    @item_destination = ItemDestination.new
    # ログインユーザーとItem出品者が同じならトップページへ繊維する。
    if @item.user == current_user && @item.buy != nil
      redirect_to root_path
    end

  end 

  def create
    @item_destination = ItemDestination.new(destination_params)
    if @item_destination.valid?
      pay_item
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
    # mergeの左側の値がフォームオブジェクトに送られている
    params.require(:item_destination).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: destination_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
