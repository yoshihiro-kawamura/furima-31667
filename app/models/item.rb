class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :buy
  has_one_attached :image
  belongs_to :area
  belongs_to :category
  belongs_to :day
  belongs_to :item_condition
  belongs_to :shipping_charge

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
end
