class React < ApplicationRecord
	belongs_to :user
	belongs_to :post, optional: true
	belongs_to :comment, optional: true

	validates :react_type, presence: true
end
