require_dependency "transit/schemas/#{Transit.orm.to_s}/media"
require 'mime/types'

module Transit
  class Media
    belongs_to :attachable, polymorphic: true
    validates :name, presence: true
    
    scope :images, lambda{ where(media_type: 'image') }
    scope :videos, lambda{ where(media_type: 'video') }
    scope :audio,  lambda{ where(media_type: 'audio') }
    
    before_validation :set_default_name
    
    attr_accessor :file
    
    ##
    # Returns whether or not this asset is an audio file based on mime type
    # 
    def audio?
      !!( content_type =~ Transit.config.audio_regexp )
    end
    
    
    ##
    # Returns whether or not this asset is an image based on mime type
    # 
    def image?
      !!( content_type =~ Transit.config.image_regexp )
    end
  
    
    ##
    # The URL to the uploaded media. 
    # Should be overridden depending on your attachment/upload engine of choice
    # 
    def url
      
    end
    
    
    ##
    # Returns whether or not this asset is a video based on mime type
    # 
    def video?
      !!( content_type =~ Transit.config.video_regexp )
    end
    
    
    private
    
    
    ##
    # Sets the media type of the uploaded asset by doing 
    # a mime_type lookup of the files extension.
    # 
    def set_default_media_type
      self.media_type = ::MIME::Types[self.content_type].first.try(:media_type) || 'file'
    end
    
    
    ##
    # Media should always have a name, if one hasn't been set, use the file name
    # 
    def set_default_name
      return true if self.name.present?
      self.name = self.file_name.to_s
    end
  end
end