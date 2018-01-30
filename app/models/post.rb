class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :reacts, dependent: :destroy
	has_many :reports, dependent: :destroy

	validates :user_id, presence: true
	validates :title, presence: true
	validates :content, presence: true, length: {maximum: 500}

	scope :all_active, -> { where.not(is_marked_remove: true) }
	scope :all_marked, -> { where(is_marked_remove: true) }

	def get_comments
		self.comments.includes(:user).where(users: { is_lock: false })
	end

	def get_comment_number
		get_comments.count
	end

	def is_reacted_by(user)
		self.reacts.where(user_id: user.id).size > 0
	end

	def get_react_number
		self.reacts.includes(:user).where(users: { is_lock: false }).count
	end

	def mark_remove
		self.is_marked_remove = true
	end

	def unmark_remove
		self.is_marked_remove = false
	end
end
