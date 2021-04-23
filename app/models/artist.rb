class Artist < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :info, length: { maximum: 200 }
  has_many_attached :images
  has_many :stage_artists, dependent: :destroy
  has_many :stage, through: :stage_artists
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :list_maps, dependent: :destroy
  has_many :lists, through: :list_maps
end
