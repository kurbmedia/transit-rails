require_dependency "transit/schemas/#{Transit.orm.to_s}/media"

module Transit
  class Media
    # All media must be uploaded into a folder.
    belongs_to :folder, class_name: "Transit::MediaFolder"
    validates :name, :folder_id, presence: true
  end
end