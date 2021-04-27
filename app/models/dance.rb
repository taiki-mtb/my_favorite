class Dance < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 100 }
  validates :info, length: { maximum: 200 }
  validates :youtube_url, presence: true
  before_save :shape_off
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :list_maps, dependent: :destroy
  has_many :lists, through: :list_maps
  has_many :comments, dependent: :destroy

  def shape_off
    self.youtube_url = youtube_url.last(11)
  end

  def feed_comment(dance_id)
    Comment.where("dance_id = ?", dance_id)
  end
end
