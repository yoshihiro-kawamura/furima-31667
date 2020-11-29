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
  has_many   :item_tags, dependent: :destroy
  has_many   :tags, through: :item_tags
  has_many   :comments, dependent: :destroy
end
