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
    @itemtagform = ItemTagForm.new
    @item = Item.new
  end

  def create
    @itemtagform = ItemTagForm.new(item_params)
    # 新しいインスタンスを生成して、そこにparamsの情報をいれている
    if @itemtagform.valid? 
      @itemtagform.save
      redirect_to items_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    # 出品者とログインしている者が一致していないと編集画面に遷移できない
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

  def search
    # keywordは検索から入ってくる内容。入ってる内容が空なら、nilを入力するという内容
    # Jsができない部分をrailsが行う。
    return nil if params[:tagname] == ""
    # Tag.whereで一致してるか
    tag = Tag.where(['tagname LIKE ?', "%#{params[:tagname]}%"])
    # jsonの記述にしている。tagをtagnameにするという記述
    render json:{ tagname: tag }
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    # mergeを入力しないと誰が投稿したのか判断できなくなるためErrorが表示されてしまう。
    params.require(:item_tag_form).permit(:name, :example, :price, :image, :category_id, :item_condition_id, :shipping_charge_id, :area_id, :day_id, :tagname).merge(user_id: current_user.id)
  end
  # .require(:item_tag_form)
  def set_item
    @item = Item.find(params[:id])
  end
end
