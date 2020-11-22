class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @item_destination = ItemDestination.new
  end

  def create
    @item = Item.find(params[:item_id])
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