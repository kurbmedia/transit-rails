module Transit
  ##
  # The base class for creating Model::Admin 
  # modules on model classes.
  # 
  class Admin
    
    ##
    # Renderer for the index component.
    # 
    def index( options = {})
      @index ||= component(:index, options)
      yield @index if block_given?
      @index
    end
    
    ##
    # Renderer for the form component
    # 
    def form(options = {})
      @form ||= component(:form, options)
      yield @form if block_given?
      @form
    end
    
    
    private
    
    
    ##
    # Finds the appropriate component to use.
    # 
    def component(action, options)
      ctype = options.delete(:type) || default_components[action]
      klass = Transit::Components.const_get(ctype.to_s.classify)
      klass.new(options)
    end
    
    
    ##
    # The default component classes
    # 
    def default_components
      {
        index: 'Table',
        form: 'Form'
      }
    end
  end
end