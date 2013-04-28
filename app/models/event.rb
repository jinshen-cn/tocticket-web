class Event < ActiveRecord::Base
  attr_accessible :address, :celebrated_at, :info, :name, :url, :paypal_account, :uri, :ticket_types_attributes

  belongs_to :organizer, :class_name => "User"
  has_many :ticket_types
  accepts_nested_attributes_for :ticket_types, :allow_destroy => true
  has_many :tickets, :through => :ticket_types
  
  validates :name, :address, :celebrated_at, :paypal_account, :formatted_celebrated_at, :uri, :presence => true
  validates :uri, :uniqueness => true, :format => { :with => /\A[a-zA-Z0-9\-_]+\z/,
                                                    :message => I18n.t('events.message.custom_uri') }
  validates :url, :allow_blank => true, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
                                                     :message => I18n.t('events.message.bad_url') }

  # Formatting in and out dates
  include FormatTime
  formatted_time_accessor :celebrated_at

  # Dates validations
  validate :dates, if: (:formatted_celebrated_at)
  def dates
    if celebrated_at < Time.current
      errors.add(:formatted_celebrated_at, I18n.t('events.message.date_future'))
    end
  end

  def set_default_custom_uri
    custom_uri = self.name.parameterize[0..20]
    if Event.find_by_uri(custom_uri)
      (1..100).each do |i|
        custom_uri = custom_uri + "-#{i}"
        break unless Event.find_by_uri(custom_uri)
      end
    end
    self.uri = custom_uri
  end

  def total_attendees
    self.tickets.inject(0) { |result, ticket| result + ticket.attendees}
  end

  def total_capacity
    self.ticket_types.inject(0) { |result, ticket_type| result + ticket_type.capacity}
  end

  def free_capacity
    total_capacity - total_attendees
  end
  
  def public_url(root_url="")
    '/to/'+ uri
  end

end