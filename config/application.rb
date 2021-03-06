require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Moneyloop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
     #config.web_console.whitelisted_ips = '172.30.0.0/16'
    # Add the "vendor" subfolder to the asset pipeline path
    config.assets.paths << Rails.root.join("vendor")

    # Add the "information" subfolder to the asset pipeline path
    config.assets.paths << Rails.root.join("app", "assets", "information")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
