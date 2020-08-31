class Book < ApplicationRecord
  belongs_to :user

  validates :status, presence: false, length: { maximum: 255 }
  validates :title, presence: false, length: { maximum: 255 }
  validates :author, presence: false, length: { maximum: 255 }
  validates :comment, presence: false, length: { maximum: 255 }

end
