class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :buys
  has_many :comments
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i.freeze
  JAPANESE_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[一-龠々])+\z/.freeze
  JAPANESE_KATAKANA_REGEX = /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/.freeze
  with_options presence: true do
    # validates :email, uniqueness: true, format: { with: User::VALID_EMAIL_REGEX }
    validates :password, format: { with: User::VALID_PASSWORD_REGEX }
    validates :birthday
    validates :nickname
    validates :first_name, format: { with: User::JAPANESE_REGEX }
    validates :last_name, format: { with: User::JAPANESE_REGEX }
    validates :last_name_kana, format: { with: User::JAPANESE_KATAKANA_REGEX }
    validates :first_name_kana, format: { with: User::JAPANESE_KATAKANA_REGEX }
  end
end
