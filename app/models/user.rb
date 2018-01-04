class User < ApplicationRecord
	attr_accessor :activation_token, :remember_token, :skip_password_validation
	has_many :friend_ship_senders,-> { where(status: 1) }, class_name: "FriendShip", foreign_key: :receiver_id, dependent: :destroy
	has_many :senders, :through => :friend_ship_senders, :source => :sender, :foreign_key => :sender_id

	has_many :friend_ship_receivers,-> { where(status: 1) }, class_name: "FriendShip", foreign_key: :sender_id, dependent: :destroy
	has_many :receivers, :through => :friend_ship_receivers, :source => :receiver, :foreign_key => :receiver_id

	has_many :friend_ship_waiters,-> { where(status: 0) }, class_name: "FriendShip", foreign_key: :receiver_id, dependent: :destroy
	has_many :waiters, :through => :friend_ship_waiters, :source => :sender, :foreign_key => :sender_id

	before_save :downcase_email
	before_create :create_activation_digest

	has_secure_password

	validates :name, :email, :presence => true
	validates :email, :uniqueness => true
	validates :password, :confirmation => true
	validates :password, :presence => true, unless: :skip_password_validation

	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth.provider,uid: auth.uid) || sign_up_from_omniauth(auth)
	end

	def self.sign_up_from_omniauth(auth)
		create(
			provider: auth.provider,
			uid: auth.uid,
			name: auth.info.name,
			email: auth.info.email,
			password: "@@@",
			activated: true,
			activated_at: Time.zone.now
		)
	end

	# Returns the hash digest of the given string.
	def User.digest(string)
		BCrypt::Password.create(string)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# decrypt activation_digest and compare to activation_token
	def authenticated?(activation_token)
		check =  BCrypt::Password.new(activation_digest).is_password?(activation_token)
		return check
	end

	def downcase_email
		self.email = email.downcase
	end

	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(activation_token)
	end

	def send_activation_mail
		UserMailer.account_activation(self).deliver_now
	end

	def activate
      	update_columns(activated: true, activated_at: Time.zone.now)
	end

	def is_activated?
		self.activated == true
	end

	def is_friend?(stranger)
		FriendShip.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", self.id, stranger.id, stranger.id, self.id).size != 0
	end

	def get_friend_senders
		self.senders
	end

	def get_friend_receivers
		self.receivers
	end

	def get_waiters
		self.waiters
	end

	def get_stranger
	end
end
