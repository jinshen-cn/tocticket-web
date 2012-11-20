class Ticket < ActiveRecord::Base
  attr_accessible :attendees, :random_key
  
  belongs_to :event
  belongs_to :user
  
  validate :attendees_cannot_exceed_event_capacity
  
  def attendees_cannot_exceed_event_capacity
    if event.capacity < event.total_attendees + attendees
      errors.add(:attendees, "Only " + event.free_capacity.to_s + " attendees free to sell")
    end
  end
end
