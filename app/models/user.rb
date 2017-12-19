class User < ApplicationRecord
	has_secure_password

	validates :name, :email, :password, :presence => true
	validates :email, :uniqueness => true
	validates :password, :confirmation => true

	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth.provider,uid: auth.uid) || sign_up_from_omniauth(auth)
	end

	def self.sign_up_from_omniauth(auth)
		create(
			provider: auth.provider,
			uid: auth.uid,
			name: auth.info.name,
			email: auth.info.email,
			password: "@@@"
		)
	end
end
