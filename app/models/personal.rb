class Personal < ActiveRecord::Base
  belongs_to :user
  mount_uploader :pic, PicUploader
end
