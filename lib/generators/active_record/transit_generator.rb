require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class TransitGenerator < ActiveRecord::Generators::Base
      
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      argument :model_type, :type => :string, :default => 'page'
      
      source_root File.expand_path("../templates", __FILE__)

      def copy_transit_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "#{model_type}_migration_existing.rb", "db/migrate/transit_add_#{model_type}_functionality_to_#{table_name}"
        else
          migration_template "#{model_type}_migration.rb", "db/migrate/transit_create_#{table_name}_with_#{model_type}_functionality"
        end
      end

      def generate_model
        invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def inject_transit_content
        content = content_to_add
        class_path = namespaced? ? class_name.to_s.split("::") : [class_name]
        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"
        inject_into_class(model_path, class_path.last, content) if model_exists?
      end
      
      private
      
      def content_to_add
        "deliver_as :#{model_type}"
      end
      
      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end
      
      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
    end
  end
end