module Transit
  ##
  # Converts a hash of region data into an array of regions.  
  # 
  class RegionBuilder < ::Array
    attr_accessor :region_data
    
    ##
    # Build a collection of regions from a regions hash.
    # 
    def initialize(data = nil)
      
      if data.is_a?(String)
        data = ::YAML.load(data)
      end

      sanitized_data = case data.class.name
      when 'Hash' || 'ActiveSupport::HashWithIndifferentAccess' then data
      when 'ActionController::Parameters' then data.to_unsafe_h
      when 'NilClass' then {}
      end

      @region_data = sanitized_data || {}
      @region_data.each do |id, props|
        self.push( Transit::Region.new(props.merge(id: id)) )
      end
      self
    end
    
    
    ##
    # Find a particular region by ID.
    # 
    def find(domid)
      self.detect{ |reg| reg.id.to_s == domid.to_s }
    end
  end

end