module Transit
  ##
  # Extends controllers to utilize app/templates for page templates.
  # 
  module Templating
    extend ActiveSupport::Concern
    ##
    # Lists all available templates from the config, includes the 
    # default template.
    # 
    def available_templates
      [Transit.config.templates, 'default'].flatten.uniq
      # [].tap do |names|
      #   ActionController::Base.view_paths.each do |path|
      #     Dir[ File.join(path, Transit.config.template_dir, '*.*') ].collect do |file|
      #       fname = File.basename(file).split('.').first
      #       next nil if fname.match(/^\_/)
      #       names << fname
      #     end.compact
      #   end
      # end
    end
  end
end