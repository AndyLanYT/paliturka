class Post < ApplicationRecord
  belongs_to :user

  validates :body, length: { maximum: 100 }
end
