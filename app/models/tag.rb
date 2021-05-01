class Tag < ApplicationRecord
  validates :tag_name, presence: true, length: { maximum: 20 }
  has_many  :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many  :dances, through: :tag_maps
  has_many  :musics, through: :tag_maps
  has_many  :stages, through: :tag_maps
end
