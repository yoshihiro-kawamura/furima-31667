class Buy < ApplicationRecord
# トークンを使う記述  
  attr_accessor :token

  belongs_to :user
  belongs_to :item
  has_one :destination
end
