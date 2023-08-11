require_relative 'boot'

require 'rails/all'
SECRETS = YAML.load(File.read(File.expand_path('../secrets.yml', __FILE__)))

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Servicios
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = 'es-MX'
    config.beginning_of_week = :sunday

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
    address:              SECRETS["mail"]["address"],
    port:                 25,
    domain:               'conabio.gob.mx',
    user_name:            SECRETS["mail"]["username"],
    password:             SECRETS["mail"]["password"],
    authentication:       'plain',
    enable_starttls_auto: true  
  }
  end
end
