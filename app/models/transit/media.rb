require_dependency "transit/schemas/#{Transit.orm.to_s}/media"

module Transit
  class Media
    # All media must be uploaded into a folder.
    belongs_to :folder, class_name: "Transit::MediaFolder"
    validates :name, presence: true
    scope :roots, lambda{ where(folder_id: nil) }
  end
end