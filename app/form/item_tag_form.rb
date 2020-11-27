class ItemTagForm
  include ActiveModel::Model

  attr_accessor :name, :example, :category_id, :item_condition_id, :shipping_charge_id, :area_id, :day_id, :price, :image, :tagname, :user_id, :tag_id

  with_options presence: true do
    validates :name
    validates :example
    validates :category_id,          numericality: { other_than: 1 , message: 'を入力してください'}
    validates :item_condition_id,    numericality: { other_than: 1 , message: 'を入力してください'}
    validates :shipping_charge_id,   numericality: { other_than: 1 , message: 'を入力してください'}
    validates :area_id,              numericality: { other_than: 0 , message: 'を入力してください'}
    validates :day_id,               numericality: { other_than: 1 , message: 'を入力してください'}
    validates :price
    validates :image
  end
  validates_inclusion_of :price, in: 300..9_999_999, message: 'が正しくありません'


  def save
    # 配送先情報の登録
    # 左側はカラム名、右側はストロングパラメーターでの値
    item = Item.create(name: name, example: example, category_id: category_id, item_condition_id: item_condition_id, shipping_charge_id: shipping_charge_id, area_id: area_id, day_id: day_id, price: price, image: image, user_id: user_id)
    tag = Tag.where(tagname: tagname).first_or_initialize
    tag.save

    ItemTag.create(item_id: item.id, tag_id: tag.id)
  end
end
