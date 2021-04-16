class Stage < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :info, length: { maximum: 500 }
  has_many_attached :images
  has_many :stage_artists, dependent: :destroy
  has_many :artists, through: :stage_artists
end
