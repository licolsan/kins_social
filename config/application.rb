require_relative 'boot'

require 'rails/all'

require 'filestack'
# require 'filepicker-rails'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KinsSocial
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.filestack_rails.api_key = 'AxBpDCNQLSAKt9qRd3EN9z'
    config.filestack_rails.client_name = 'licolsan_filestack'
    config.filestack_rails.app_secret = 'WMANIWEIBVHHFMTCTM6KU7B7KY'
	config.filestack_rails.security = {'call' => %w[pick store read convert] }


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
