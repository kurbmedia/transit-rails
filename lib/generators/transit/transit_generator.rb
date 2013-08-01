module Transit
  module Generators
    class TransitGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      argument :model_type, :type => :string, :default => 'page'
      
      source_root File.expand_path("../../templates", __FILE__)
      namespace "transit"
      
      desc "Generates a model with the given NAME (if one does not exist) with transit configuration plus migration / fields."
      
      hook_for :orm
    end
  end
end