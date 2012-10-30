class Showcase < ActiveRecord::Base
  attr_accessible :title, :description

  validates_presence_of :title

  after_save :verify

  state_machine :initial => :dummy do
    state :dummy
    state :prepared

    event :verify do
      transition :dummy => :prepared, if: lambda {|showcase| showcase.description.present? }
      transition :prepared => :dummy, if: lambda {|showcase| showcase.description.blank? }
    end
  end
end
