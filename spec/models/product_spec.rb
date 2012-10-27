require 'spec_helper'

describe Product do
  subject { build(:product) }
  it "has a valid factory" do
    subject.should be_valid
  end
  describe "validation requirements" do
    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:price) }
    it "price must be positive" do
      build(:product, price: 0).should have(1).error_on(:price)
    end
  end
end
