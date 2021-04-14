class Stage < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :info, length: { maximum: 500 }
end
