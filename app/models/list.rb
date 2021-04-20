class List < ApplicationRecord
  validates :list_name, presence: true, length: { maximum: 20 }
  has_many  :list_maps, dependent: :destroy, foreign_key: 'list_id'
  has_many  :dances, through: :list_maps
  has_many  :musics, through: :list_maps
  has_many  :stages, through: :list_maps
end
