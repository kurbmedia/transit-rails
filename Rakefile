begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Transit'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# 
# task :load_app do
#   require 'action_controller/railtie'
#   require 'konacha'
#   puts "KONACHA!"
#   module Konacha
#     def self.spec_root
#       ::Transit::Engine.config.root + config.spec_dir
#     end
#   end
#   
#   class Konacha::Engine
#     initializer "konacha.engine.environment", after: "konacha.environment" do
#       # Rails.application is the dummy app in test/dummy
#       ::Rails.application.config.assets.paths << ::Transit::Engine.config.root + ::Konacha.config.spec_dir
#     end
#   end
#   
#   load 'tasks/konacha.rake'
# end

Bundler::GemHelper.install_tasks

task :default => :spec