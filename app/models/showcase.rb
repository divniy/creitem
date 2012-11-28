class Showcase < ActiveRecord::Base
  attr_accessible :title, :description

  validates_presence_of :title
  before_save :prepare, :if => lambda {|showcase| showcase.can_prepare?}
  before_save :toggle_activity, :if => lambda {|showcase| showcase.toggle_activity?}

  state_machine :initial => :dummy do
    event :prepare do
      transition :dummy => :complete, :if => lambda {|showcase| showcase.description.present?}
      transition :complete => :dummy, :if => lambda {|showcase| !showcase.description.present?}
    end

    event :activate do
      transition :complete => :active
    end

    event :deactivate do
      transition :active => :complete
    end

    event :toggle_activity do
      transition :complete => :active
      transition :active => :complete
    end
  end

  def active
    return @active if !@active.nil?
    active?
  end

  def active=(value)
    @active = (value == "1") ? true : false
  end

  def toggle_activity?
    active != active?
  end
end
