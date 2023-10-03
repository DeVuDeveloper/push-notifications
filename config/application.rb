require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Bazzar
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths << Rails.root.join("lib")
  end
end
