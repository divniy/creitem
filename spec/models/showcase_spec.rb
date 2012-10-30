require 'spec_helper'

describe Showcase do
  it { should validate_presence_of(:title) }
  its(:state) { should eq("dummy") }

  describe "#verify after save" do
    context "with :dummy state" do
      subject { create(:showcase) }

      it "became :prepared if has description" do
        subject.description = "presence"
        expect{subject.save}.to change{subject.state}.from("dummy").to("prepared")
      end
    end

    context "with :prepared state" do
      subject { create(:prepared_showcase) }

      it "change state prepared_showcase without description" do
        subject.description = ""
        expect{subject.save}.to change{subject.state}.from("prepared").to("dummy")
      end
    end
  end
end
