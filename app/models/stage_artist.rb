class StageArtist < ApplicationRecord
  belongs_to :stage
  belongs_to :artist
end
