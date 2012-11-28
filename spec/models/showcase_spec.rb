require 'spec_helper'

describe Showcase do
  it { should validate_presence_of(:title) }
  its(:state) { should eq("dummy") }

  context 'with :dummy state' do
    subject { build(:dummy_showcase) }

    it { should be_valid }

    it "can be prepared when has description" do
      subject.description = "presence"
      expect(subject.can_prepare?).to be_true
    end

    it "become complete when can be prepared" do
      subject.description = "presence"
      expect{subject.save}.to change{subject.state}.from("dummy").to("complete")
    end
  end

  context 'with :complete state' do
    subject { build(:complete_showcase) }

    it "can be prepared when has no description" do
      subject.description = ""
      expect(subject.can_prepare?).to be_true
    end

    it "can be activated" do
      expect{subject.activate}.to change{subject.state}.from("complete").to("active")
    end

    it "can toggle activity by attribute" do
      subject.active = "1"
      expect{subject.save}.to change{subject.state}.from("complete").to("active")
    end
  end

  context 'with :active state' do
    subject { build(:active_showcase) }

    it "can be deactivated" do
      expect{subject.deactivate}.to change{subject.state}.from("active").to("complete")
    end

    it "can toggle activity by attribute to complete" do
      subject.active = "0"
      expect{subject.save}.to change{subject.state}.from("active").to("complete")
    end
  end
  
  
end
