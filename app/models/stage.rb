class Stage < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :info, length: { maximum: 500 }
  has_many_attached :images
end
