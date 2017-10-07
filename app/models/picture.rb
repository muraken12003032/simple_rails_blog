class Picture < ActiveRecord::Base
  mount_uploader :image, PictureUploader
  has_one :thumbnail
end