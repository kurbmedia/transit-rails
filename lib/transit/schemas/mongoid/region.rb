module Transit
  class Region
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :dom_id,        :type => String
    field :content,       :type => String
    field :region_type,   :type => String
    field :data,          :type => Hash,   :default => {}
    field :snippet_data,  :type => Hash,   :default => {}
    field :draft_content, :type => String
    field :publish_state, :type => String, :default => "draft"
    
    embedded_in :page, :class_name => "Transit::Page"
  end
end