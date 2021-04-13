class Music < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	validates :name, presence: true, length: { maximum: 50 }
	validates :info, length: { maximum: 200 }
end
