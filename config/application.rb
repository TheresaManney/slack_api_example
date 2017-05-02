require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SlackApiExample
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # an array of folders that will load up our data?... not sure if thats true
    # the line below is the slack API wrapper
    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.test_framework :minitest, spec: true
    end
  end
end
