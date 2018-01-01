CarrierWave.configure do |config|
	if Rails.env.development? || Rails.env.test?
		config.storage = :file
	end
	if Rails.env.production?
		config.storage = :fog
	end
	config.fog_credentials = {
		:provider => 'AWS',
		:aws_access_key_id => 'AKIAJJBC3H34H5XE36UQ',
		:aws_secret_access_key => '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',
	}
	config.fog_directory = 'my_uploads'
	# config.fog_public = false
	config.fog_authenticated_url_expiration = 1.minute
end