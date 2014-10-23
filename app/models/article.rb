class Article < ActiveRecord::Base
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :comments , dependent: :destroy
end
