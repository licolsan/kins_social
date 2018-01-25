class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :friend_ship_senders,-> { where(status: 1) }, class_name: "FriendShip", foreign_key: :receiver_id, dependent: :destroy
	has_many :senders, :through => :friend_ship_senders, :source => :sender, :foreign_key => :sender_id

	has_many :friend_ship_receivers,-> { where(status: 1) }, class_name: "FriendShip", foreign_key: :sender_id, dependent: :destroy
	has_many :receivers, :through => :friend_ship_receivers, :source => :receiver, :foreign_key => :receiver_id

	has_many :friend_ship_waiters,-> { where(status: 0) }, class_name: "FriendShip", foreign_key: :receiver_id, dependent: :destroy
	has_many :waiters, :through => :friend_ship_waiters, :source => :sender, :foreign_key => :sender_id

	has_many :friend_ship_blocked_senders,-> { where(status: 2) }, class_name: "FriendShip", foreign_key: :receiver_id, dependent: :destroy
	has_many :blocked_senders, :through => :friend_ship_blocked_senders, :source => :sender, :foreign_key => :sender_id

	has_many :friend_ship_blocked_receivers,-> { where(status: 2) }, class_name: "FriendShip", foreign_key: :sender_id, dependent: :destroy
	has_many :blocked_receivers, :through => :friend_ship_blocked_receivers, :source => :receiver, :foreign_key => :receiver_id

	has_many :posts, dependent: :destroy

	has_many :active_relationships, class_name: "FollowRelationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followings, :through => :active_relationships, :source => :followed

	has_many :passive_relationships, class_name: "FollowRelationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followers, :through => :passive_relationships, :source => :follower

	has_many :comments, dependent: :destroy
	has_many :reacts, dependent: :destroy

	has_many :messages
	has_many :subscriptions
	has_many :channels, through: :subscriptions

	has_many :reports, dependent: :destroy

	mount_uploader :avatar, ImageUploader
	mount_uploader :cover_photo, ImageUploader

	validates :name, presence: true

	scope :all_except, -> (user) { where.not(id: user.id) }

	def self.form_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		user.name = auth.info.name
  		user.email = auth.info.email
  		user.provider = auth.provider
  		user.uid = auth.uid
  		user.password = rand().to_s
  		user.skip_confirmation!
  	end
  end

	def is_friend?(stranger)
		FriendShip.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", self.id, stranger.id, stranger.id, self.id).size > 0
	end

	def get_friend_senders
		self.senders
	end

	def get_friend_receivers
		self.receivers
	end

	def get_friend_number
		(get_friend_senders.size + get_friend_receivers.size)
	end

	def get_waiters
		self.waiters
	end

	def get_waiter_number
		get_waiters.size
	end

	def get_blocked_senders
		self.blocked_senders
	end

	def get_blocked_receivers
		self.blocked_receivers
	end

	def get_blocked_number
		(get_blocked_senders.size + get_blocked_receivers.size)
	end

	def get_followers
		self.followers
	end

	def get_followings
		self.followings
	end

	def is_following?(user)
		FollowRelationship.where("follower_id = ? AND followed_id = ?", self.id, user.id).size > 0
	end
end
