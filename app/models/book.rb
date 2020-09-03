class Book < ApplicationRecord
  belongs_to :user

  validates :status, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :author, presence: false, length: { maximum: 50 }
  validates :comment, presence: false, length: { maximum: 255 }

end
