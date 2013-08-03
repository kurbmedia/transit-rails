module Transit
  
  ##
  # Placeholder class for field types
  # 
  class ContentField
    attr_accessor :type, :id, :content, :node, :position
    
    ##
    # Create a field from a hash.
    # 
    def initialize(data = {})
      data.each do |key, value|
        self.send(:"#{key.to_s}=", value)
      end
    end
  end
  
  ##
  # A schematic represents the structure in which the model's
  # content is defined. 
  # 
  class Schematic < Hash

    ##
    # Build the hash by sorting the data by key.
    # Data is created using a structure matching that of 
    # a nested_attributes hash.
    # 
    # 
    def initialize(data = {})
      data = (data || {}).stringify_keys!
      data.keys.map(&:to_i).sort.each do |key|
        self[key] = data[key.to_s]
      end
    end
    
    ##
    # Returns an array of the field types found 
    # in the underlying hash.
    # 
    def content_types
      self.values.collect do |hash|
        (hash || {})['type']
      end.compact
    end
    
    ##
    # Create an array of objects based on the stored data.
    # 
    def to_data
      self.keys.collect do |key|
        Transit::ContentField.new(self[key].merge("position" => key.to_i))
      end
    end
    
    class << self

      ##
      # Mongoid conversion
      # 
      def demongoize(data)
        Transit::Schematic.new(data || {})
      end
      
      def mongoize(object)
        case object
        when Transit::Schematic then object.mongoize
        when Hash then Transit::Schematic.new(object).mongoize
        else object
        end
      end
    end
  end
end