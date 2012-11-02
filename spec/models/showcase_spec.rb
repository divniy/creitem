require 'spec_helper'

describe Showcase do
  it { should validate_presence_of(:title) }
  its(:state) { should eq("dummy") }

  describe "state machine behavior" do
    #describe "state"
    context "with :dummy state" do
      subject { create(:showcase) }

      it "became :prepared only if has description" do
        subject.description = "presence"
        expect{subject.save}.to change{subject.state}.from("dummy").to("prepared")
      end
    end

    context "with :prepared state" do
      subject { create(:complete_showcase) }

      it "became :dummy if has not description" do
        subject.description = ""
        expect{subject.save}.to change{subject.state}.from("prepared").to("dummy")
      end
      it "can be activate by view" do
        expect(subject.public_state_events).to include(:activate)
      end
      it "#activate event change state to :active" do
        expect{subject.activate}.to change{subject.state}.from("prepared").to("active")
      end
    end

    context "with :active state" do
      subject { create(:complete_showcase, :active) }

      it { should validate_presence_of :description }
      it "can be deactivate by view" do
        expect(subject.public_state_events).to include(:deactivate)
      end
      it "#deactivate event change state to :prepared" do
        expect{subject.deactivate}.to change{subject.state}.from("active").to("prepared")
      end
    end
  end

  describe "#is_active" do
    it "true for active showcase" do
      showcase = build(:complete_showcase, :active)
      expect(showcase.is_active).to be_true
    end

    it "false for prepared showcase" do
      showcase = build(:complete_showcase)
      expect(showcase.is_active).to be_false
    end
  end

  describe "#is_active=" do
    it "activate showcase when true" do
      showcase = build(:complete_showcase, :prepared, is_active: '1')
      expect{showcase.save}.to change{showcase.state}.from("prepared").to("active")
    end
    it "deactivate showcase when false" do
      showcase = build(:complete_showcase, :active, is_active: '0')
      expect{showcase.save}.to change{showcase.state}.from("active").to("prepared")
    end
  end
end
