class Event < ActiveRecord::Base
  attr_accessible :address, :celebrated_at, :door_payment, :info, :name, :price, :selling_deadline, :capacity, :url
  
  belongs_to :organizer, :class_name => "User"
  has_many :tickets
  
  validate :attendees_cannot_be_higher_than_capacity
  
  def attendees_cannot_be_higher_than_capacity
    if capacity < total_attendees
      errors.add(:capacity, "Attendees exceed capacity")
    end
  end

  def total_attendees
    self.tickets.inject(0) { |result, ticket| result + ticket.attendees}
  end
  
  def free_capacity
    capacity - total_attendees
  end

end