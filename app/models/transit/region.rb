module Transit
  class Region
    include ActiveModel::Naming
    include ActiveModel::Serialization
    
    attr_reader :id, :content, :type, :data, :snippet_data
    attr_accessor :attributes
    
    def initialize(data = nil)
      @attributes = (data || {}).stringify_keys!
      @attributes.each do |key, value|
        key = "content" if key.to_s.eql?('value')
        instance_variable_set("@#{key.to_s}", value)
      end
    end
  end
end