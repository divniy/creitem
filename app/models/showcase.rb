class Showcase < ActiveRecord::Base
  attr_accessible :title, :description, :active

  validates_presence_of :title
  validate :content_ready_when_active

  before_save :correct_state, :if => lambda {|showcase| showcase.can_correct_state?}
  before_save :toggle_activity, :if => lambda {|showcase| showcase.active != showcase.active?}

  state_machine :initial => :dummy do
    state :dummy
    state :complete
    state :active do
      validates_presence_of :description, :if => :active
    end

    event :correct_state do
      transition :dummy => :complete, :if => :content_ready?
      transition :complete => :dummy, :unless => :content_ready?
    end   

    event :toggle_activity do
      transition :complete => :active
      transition :active => :complete
    end
  end

  def active
    return active? if @active.nil?
    @active
  end

  def active=(value)
    @active = (value == "1")
  end  

  def content_ready?
    description.present?
  end

  def content_ready_when_active
    errors.add(:active, "can`t be active without required content") if active && !content_ready?
  end
end
