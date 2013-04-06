class Event < ActiveRecord::Base
  attr_accessible :address, :celebrated_at, :info, :name, :price, :capacity, :url, :paypal_account, :uri

  belongs_to :organizer, :class_name => "User"
  has_many :tickets
  
  validates :name, :address, :price, :celebrated_at, :capacity, :paypal_account, :formatted_celebrated_at, :uri, :presence => true
  validates :uri, :uniqueness => true, :format => { :with => /\A[a-zA-Z0-9\-_]+\z/,
                                                    :message => "Allowed: letters, numbers, '-' and '_'" }
  validates :url, :uniqueness => true, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
                                                    :message => "Please, introduce a valid URL" }
  validates :price, :capacity, :numericality => { :greater_than_or_equal_to => 0 }

  # Formatting in and out dates
  include FormatTime
  formatted_time_accessor :celebrated_at

  # Dates validations
  validate :dates, if: (:formatted_celebrated_at)
  def dates
    if celebrated_at < Time.current
      errors.add(:formatted_celebrated_at, "Date of event should be in the future")
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