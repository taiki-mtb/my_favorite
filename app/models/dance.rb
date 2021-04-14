class Dance < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 100 }
  validates :info, length: { maximum: 200 }
  validates :youtube_url, presence: true
  before_save :shape_off

  def shape_off
    self.youtube_url = youtube_url.last(11)
  end
end
