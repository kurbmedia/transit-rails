module Transit
  ##
  # Utilized within Pages to provide template data 
  # such as available templates.
  # 
  module Templating
    
    ##
    # Get a list of all templates/views in the template_dir 
    # setup in the global configuration.
    # 
    def available_templates
      [].tap do |names|
        ActionController::Base.view_paths.each do |path|
          Dir[ File.join(path, Transit.config.template_dir, '*.*') ].collect do |file|
            fname = File.basename(file).split('.').first
            next nil if fname.match(/^\_/)
            names << fname
          end.compact
        end
      end
    end

  end
end