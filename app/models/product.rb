class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :image, :image_cache

  validates :title, :description, :price, presence: true
  validates_uniqueness_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0.01

  mount_uploader :image, ImageUploader
end
