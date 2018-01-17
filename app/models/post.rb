class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :reacts, dependent: :destroy

	validates :user_id, presence: true
	validates :title, presence: true
	validates :content, presence: true, length: {maximum: 500}

	def get_comments
		self.comments
	end

	def get_comment_number
		get_comments.count
	end

	def is_reacted_by(user)
		self.reacts.where(user_id: user.id).size > 0
	end

	def get_react_number
		self.reacts.count
	end
end
