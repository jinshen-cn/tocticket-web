class Event < ActiveRecord::Base
  attr_accessible :address, :celebrated_at, :door_payment, :info, :name, :price, :selling_deadline, :capacity, :url, :paypal_account
  
  belongs_to :organizer, :class_name => "User"
  has_many :tickets
  
  validates :name, :address, :price, :celebrated_at, :selling_deadline, :capacity, :paypal_account, :presence => true
  validates :price, :capacity, :numericality => { :greater_than_or_equal_to => 0 }
  # Dates validations
  validate :dates, if: (:celebrated_at and :selling_deadline)
  def dates
    if celebrated_at < Time.current
      errors.add(:celebrated_at, "Date of event should be in the future")
    end
    
    if selling_deadline < Time.current
      errors.add(:selling_deadline, "Selling deadline should be in the future")
    end
    
    if selling_deadline > celebrated_at
      msg = "Day of Event should be later or the same time as the ticket sales deadline"
      errors.add(:celebrated_at, msg)
      errors.add(:selling_deadline, msg)
    end
  end

  # Capacity validation
  validate :attendees_cannot_be_higher_than_capacity, if: :capacity
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
  
  def public_url(root_url="")
    root_url+'events/'+id.to_s
  end

end