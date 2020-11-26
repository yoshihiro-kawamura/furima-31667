class ItemDestination
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id, numericality: { other_than: 0, message: 'を入力してください'}
    validates :city
    validates :house_number
    validates :phone_number
    validates :token
  end
  validates :postal_code, format:           { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'を入力してください' }, allow_blank: true
  validates :phone_number, format:          { with: /\A\d{11}\z/, message: 'を入力してください'}, allow_blank: true

  def save
    # 配送先情報の登録
    # 左側はカラム名、右側はストロングパラメーターでの値
    @buy = Buy.create(user_id: user_id, item_id: item_id)
    Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, phone_number: phone_number, buy_id: @buy.id)
  end
end
