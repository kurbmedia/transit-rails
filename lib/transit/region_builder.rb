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
      return self unless data.is_a?(Hash)
      @region_data = data
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