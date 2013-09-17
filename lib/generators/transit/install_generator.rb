module Transit
  module Generators
    ##
    # Generates a configuration initializer in config/initializers 
    # including documentation and default options.
    # 
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_files
        template "transit.rb", "config/initializers/transit.rb"
        template "page_migration.rb", "db/migrations/#{Time.now.to_i}_transit_create_pages.rb"
      end
    end
    
  end
end