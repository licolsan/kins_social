class FriendShip < ApplicationRecord
	scope :waiting, -> { where(status: 0) }
	scope :accepted, -> { where(status: 1) }
	scope :blocked, -> { where(status: 2) }

	belongs_to :sender, :class_name => "User"
	belongs_to :receiver, :class_name => "User"

	def accept
		self.status = 1
	end

	def block
		self.status = 2
	end

	def unblock
		self.status = 1
	end

	def unfriend
		self.destroy
	end
end
