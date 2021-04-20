class ListMap < ApplicationRecord
  belongs_to :dance, optional: true
  belongs_to :music, optional: true
  belongs_to :stage, optional: true
  belongs_to :list
  validates :list_id,presence:true
end
