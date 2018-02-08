require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module LeadAdvalori
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
    end

    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Use the APIs inside lib/ NOTE: this may cause the app to run slower (Joaquim - 2017/01/10)
    config.autoload_paths += %W(#{config.root}/lib/assets)
    # config.autoload_paths << Rails.root.join('lib')
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]


    # Code from Inspinia template below
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.precompile += [ 'appviews.css', 'cssanimations.css', 'dashboards.css', 'forms.css', 'gallery.css', 'graphs.css', 'mailbox.css', 'miscellaneous.css', 'pages.css', 'tables.css', 'uielements.css', 'widgets.css', 'commerce.css' ]  +
    config.assets.precompile += [ 'appviews.js', 'cssanimations.js', 'dashboards.js', 'forms.js', 'gallery.js', 'graphs.js', 'mailbox.js', 'miscellaneous.js', 'pages.js', 'tables.js', 'uielements.js', 'widgets.js', 'commerce.js', 'metrics.js', 'landing.js' ]

  end
end

