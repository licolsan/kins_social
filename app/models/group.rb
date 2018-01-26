class Group < ApplicationRecord
	has_many :member_ships, dependent: :destroy
	has_many :users, through: :member_ships

	validates :name, presence: true
	validates :group_type, presence: true

	mount_uploader :avatar, ImageUploader
	mount_uploader :cover_photo, ImageUploader

	def is_owned_by(user)
		owner = User.find(self.member_ships.find_by(is_owner: true).user_id)
		if owner.id == user.id
			return true
		else
			return false
		end
	end

	def has_member(user)
		member_ship = self.member_ships.where(user_id: user.id)
		if member_ship.size == 0
			return false
		else
			return true
		end
	end
end
