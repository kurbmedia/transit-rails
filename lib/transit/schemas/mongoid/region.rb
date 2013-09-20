module Transit
  class Region
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :dom_id,       :type => String
    field :content,      :type => String
    field :type,         :type => String
    field :data,         :type => Hash, :default => {}
    field :snippet_data, :type => Hash, :default => {}
    
    embedded_in :page, :class_name => "Transit::Page"
  end
end