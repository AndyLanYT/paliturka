class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, length: { maximum: 25 }
  validates :last_name, length: { maximum: 30 }
  validates :info, length: { maximum: 150 }
end
