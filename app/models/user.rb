class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
  has_one_attached :image

  with_options presence: true do
    validates :nickname, length: { maximum: 12 }
    validates :team
    validates :position
  end

  with_options format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "半角英数字にしてください", on: :create } do
    validates :password
    validates :password_confirmation
  end
end
