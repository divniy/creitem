class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price

  validates :title, :description, :price, presence: true
  validates_uniqueness_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
end
