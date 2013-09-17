require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class TransitGenerator < ActiveRecord::Generators::Base
      
      source_root File.expand_path("../templates", __FILE__)

      def copy_transit_migration
        migration_template "transit_migration.rb", "db/migrate/install_transit"
      end
    end
  end
end