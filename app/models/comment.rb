class Comment < ApplicationRecord
	belongs_to :post
	belongs_to :user
	has_many :reacts, dependent: :destroy

	validates :content, presence: true

	def is_belong_to(user)
		self.user == user
	end

	def is_reacted_by(user)
		self.reacts.where(user_id: user.id).size > 0
	end

	def get_react_number
		self.reacts.count
	end
end
