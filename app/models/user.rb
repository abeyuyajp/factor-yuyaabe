class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :password_confirmation, format: {with: /[a-z\d]{6,}/i}
    validates :team
    validates :position
  end
    validates :password, format: {with: /[a-z\d]{6,}/i}
end
