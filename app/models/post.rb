class Post < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :title, length: { maximum: 100, message: 'が長すぎます' }
    validates :youtube_url
    validates :text
  end
end
