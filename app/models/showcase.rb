class Showcase < ActiveRecord::Base
  attr_accessible :title, :description, :public_state_event, :is_active

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
      transition :active => same
    end
    event :deactivate do
      transition :active => :prepared
      transition :prepared => same
    end
    event :toggle_active do
      transition :prepared => :active
      transition :active => :prepared
    end
  end

  def is_active
    active?
  end

  def is_active=(value)
    bool_value = (value == '1') ? true : false
    self.public_state_event = :toggle_active if bool_value != is_active
  end
end
