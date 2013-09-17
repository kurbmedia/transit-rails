module Transit
  module Generators
    ##
    # Generates a configuration initializer in config/initializers 
    # including documentation and default options.
    # 
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      class_option :orm
      
      def copy_files
        template "transit.rb", "config/initializers/transit.rb"
        if active_record?
          template "page_migration.rb", "db/migrations/#{Time.now.to_i}_transit_create_pages.rb"
        end
      end
      
      private
      
      def active_record?
        options[:orm].to_s == 'active_record'
      end
    end
    
  end
end