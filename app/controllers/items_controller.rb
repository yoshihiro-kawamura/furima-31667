class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @item = Item.all
  end

  def new
    @item = Item.new()
  end

  def create
    @item = Item.new(item_params)
    #新しいインスタンスを生成して、そこにparamsの情報をいれている
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  private
  def item_params
    # mergeを入力しないと誰が投稿したのか判断できなくなるためErrorが表示されてしまう。
    params.require(:item).permit(:name, :example, :price, :image, :category_id, :item_condition_id, :shipping_charge_id, :area_id, :day_id).merge(user_id: current_user.id)
  end
end
