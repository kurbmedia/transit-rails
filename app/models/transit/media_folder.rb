require_dependency "transit/schemas/#{Transit.orm.to_s}/media_folder"

module Transit
  class MediaFolder
    
    validates :name, presence: true, uniqueness: { scope: :ancestry, case_sensitive: false }
    before_save :generate_path
    
    private
    
    
    ##
    # To speed up fetching of specific folders, cache the path to this folder,
    # based on its ancestry.
    # 
    def generate_path
      parts = [ancestors(to_depth: depth).collect(&:name), name].flatten.compact.map do |part|
        part.to_slug.underscore
      end
      self.full_path = sprintf("/%s", parts.join("/"))
    end
  end
end