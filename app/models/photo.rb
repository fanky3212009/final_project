class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_many :tags, :as => :taggable
  mount_uploader :picture, PictureUploader
  has_many :comments, as: :commentable

end
