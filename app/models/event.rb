class Event < ActiveRecord::Base
  attr_accessible :address, :celebrated_at, :door_payment, :info, :name, :price, :selling_deadline, :capacity, :url, :paypal_account, :uri

  belongs_to :organizer, :class_name => "User"
  has_many :tickets
  
  validates :name, :address, :price, :celebrated_at, :selling_deadline, :capacity, :paypal_account, :formatted_celebrated_at, :formatted_selling_deadline, :uri, :presence => true
  validates :uri, :uniqueness => true, :format => { :with => /\A[a-zA-Z0-9\-_]+\z/,
                                                    :message => "Allowed: letters, numbers, '-' and '_'" }
  validates :price, :capacity, :numericality => { :greater_than_or_equal_to => 0 }

  # Formatting in and out dates
  include FormatTime
  formatted_time_accessor :celebrated_at, :selling_deadline

  # Dates validations
  validate :dates, if: (:formatted_celebrated_at and :formatted_selling_deadline)
  def dates
    if celebrated_at < Time.current
      errors.add(:formatted_celebrated_at, "Date of event should be in the future")
    end
    
    if selling_deadline < Time.current
      errors.add(:formatted_selling_deadline, "Selling deadline should be in the future")
    end
    
    if selling_deadline > celebrated_at
      msg = "Day of Event should be later or the same time as the ticket sales deadline"
      errors.add(:formatted_celebrated_at, msg)
      errors.add(:formatted_selling_deadline, msg)
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
    '/to/'+ uri
  end

end