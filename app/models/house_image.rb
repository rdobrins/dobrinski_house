class HouseImage < ApplicationRecord
  mount_uploader :image, ImageUploader
end
