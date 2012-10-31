class Showcase < ActiveRecord::Base
  attr_accessible :title, :description

  validates_presence_of :title

  after_save :verify

  state_machine :initial => :dummy do
    state :dummy
    state :prepared
    state :active do
      validates_presence_of :description
    end

    event :verify do
      transition :dummy => :prepared, if: lambda {|showcase| showcase.description.present? }
      transition :prepared => :dummy, if: lambda {|showcase| showcase.description.blank? }
    end
  end

  state_machine :public_state, :attribute => :state do
    event :activate do
      transition :prepared => :active
    end
    event :deactivate do
      transition :active => :prepared
    end
  end
end
