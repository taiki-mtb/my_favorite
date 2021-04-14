class Artist < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :info, length: { maximum: 200 }
  has_many_attached :images
end
