module Mongoid
  module Generators
    class TransitGenerator < Rails::Generators::NamedBase
      argument :model_type, :type => :string, :required => false
      
      source_root File.expand_path("../templates", __FILE__)
      
      def generate_model
        invoke "mongoid:model", [name] unless model_exists? && behavior == :invoke
      end

      def inject_transit_content
        inject_into_file model_path, "  deliver_as :#{transit_model}\n", :after => "include Mongoid::Document\n" if model_exists?
      end
      
      private
      
      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end
      
      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
      
      def transit_model
        return model_type if model_type
        return name if name.to_s.match(/(page|post)/i)
        "post"
      end
      
    end
  end
end