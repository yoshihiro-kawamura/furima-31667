class Destination < ApplicationRecord
  belongs_to :buy
# Active hashを使う際はこの記述↓をしなくてはいけない
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
