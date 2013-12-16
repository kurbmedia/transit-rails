require_dependency "transit/schemas/#{Transit.orm.to_s}/media_folder"

module Transit
  class MediaFolder
    # Media uploads belong to a folder
    has_many :files, class_name: "Transit::Media"
    validates :name, presence: true
  end
end