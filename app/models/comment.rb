class Comment < ApplicationRecord
  belongs_to :dance, optional: true
  belongs_to :music, optional: true
  belongs_to :stage, optional: true
  validates :content, presence: true, length: { maximum: 100 }
end
