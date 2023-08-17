class Sermon < ApplicationRecord
    belongs_to :admin
    mount_uploader :video, SermonUploader
end
