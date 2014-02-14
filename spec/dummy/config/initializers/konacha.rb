require 'konacha'

Konacha.configure do |config|
  config.spec_dir     = "spec/javascripts"
  config.spec_matcher = /_spec\.|_test\./
  config.stylesheets  = %w(application)
  #config.driver       = :selenium
end

module Konacha
  def self.spec_root
    ::Transit::Engine.config.root + config.spec_dir
  end
end