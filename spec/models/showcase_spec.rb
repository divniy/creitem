require 'spec_helper'

describe Showcase do
  it { should validate_presence_of(:title) }
  its(:state) { should eq("dummy") }

  context 'with :dummy state' do
    subject { build(:dummy_showcase) }   

    it "become complete when content ready" do
      subject.stub(:content_ready? => true)
      expect{subject.save}.to change{subject.state}.from("dummy").to("complete")
    end
  end

  context 'with :complete state' do
    subject { build(:complete_showcase) }

    it "become :dummy without description" do
      subject.stub(:content_ready? => false)
      expect{subject.save}.to change{subject.state}.from("complete").to("dummy")
    end  

    it "can be activated by attribute" do
      subject.active = "1"
      expect{subject.save}.to change{subject.state}.from("complete").to("active")
    end

    it "#active has errors if true without content ready" do
      subject.stub(:content_ready? => false, :active => true)
      expect(subject).to have(1).error_on(:active)
    end
  end

  context 'with :active state' do
    subject { build(:active_showcase) }  
    it { should validate_presence_of(:description) }

    it "can toggle activity by attribute to complete" do
      subject.active = "0"
      expect{subject.save}.to change{subject.state}.from("active").to("complete")
    end
  end  
end
