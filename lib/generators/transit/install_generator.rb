module Transit
  module Generators
    
    ##
    # Generates a configuration initializer in config/initializers 
    # including documentation and default options.
    # 
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      class_option :orm
      
      ##
      # Copy initializer and optional migration
      # 
      def copy_files
        template "transit.rb",        "config/initializers/transit.rb"
        template "transit.js",        "app/assets/javascripts"
        template "transit.css.scss",  "app/assets/stylesheets"
        
        return unless active_record?
        require_migration_helpers!
        migration_template "transit_migration.rb", "db/migrate/install_transit.rb"
      end
      
      
      class << self
        
        ##
        # Required interface for activerecord 
        # migration templates
        # 
        def next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ::ActiveRecord::Migration.next_migration_number(next_migration_number)
        end
      end
      
      
      private
      
      
      ##
      # Is the ORM activerecord?
      # 
      def active_record?
        options[:orm].to_s == 'active_record'
      end
      
      
      ##
      # For AR we need a migration_template method to 
      # generate migrations.
      # 
      def require_migration_helpers!
        return true if self.respond_to?(:migration_template)
        require 'rails/generators/migration'
        self.class.send(:include, Rails::Generators::Migration)
      end
    end
    
  end
end