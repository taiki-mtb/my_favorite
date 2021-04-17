class TagMap < ApplicationRecord
  belongs_to :dance, optional: true
  belongs_to :music, optional: true
  belongs_to :stage, optional: true
  belongs_to :tag
  validates :tag_id,presence:true
end
