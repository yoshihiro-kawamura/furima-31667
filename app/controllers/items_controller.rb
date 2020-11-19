class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    # @itemを@itemsにする。その理由は複数のレコードを取得するため、＠Itemだと1つしか持ってこれない
    # orderメソッドは画像を新しい順にならばせたいから,imageを入力するとErrorになってしまう。
    # orderメソッドにimageを入力しないで、日時を表すものにすれば投稿順に表示してくれる。
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # 新しいインスタンスを生成して、そこにparamsの情報をいれている
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    #出品者とログインしている者が一致していないと編集画面に遷移できない
    if @item.user == current_user
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      render :show
  end

  private

  def item_params
    # mergeを入力しないと誰が投稿したのか判断できなくなるためErrorが表示されてしまう。
    params.require(:item).permit(:name, :example, :price, :image, :category_id, :item_condition_id, :shipping_charge_id, :area_id, :day_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end