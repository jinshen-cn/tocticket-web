class Ticket < ActiveRecord::Base
  attr_accessible :attendees, :unpaid, :random_key
  
  belongs_to :event
  belongs_to :user
  
  validates :attendees, :numericality => {:greater_than => 0}
  validate :attendees_cannot_exceed_event_capacity, :if => :attendees
  
  def attendees_cannot_exceed_event_capacity
    if event.capacity < event.total_attendees + attendees
      errors.add(:attendees, "Only " + event.free_capacity.to_s + " attendees free to sell")
    end
  end
  
  before_save :default_values
  def default_values
    self.random_key ||= SecureRandom.hex(16)
  end
  
end
