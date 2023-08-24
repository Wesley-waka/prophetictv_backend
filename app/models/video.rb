class Video < ApplicationRecord
  include ActiveStorageBase64::Support::Base64Image
  has_base64_image :image
  mount_uploader :video, VideoUploader
  end
  