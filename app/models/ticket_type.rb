class TicketType < ActiveRecord::Base
  attr_accessible :capacity, :name, :price
  belongs_to :event
  has_many :tickets

  validates :price, :capacity, :numericality => { :greater_than_or_equal_to => 0 }

  # Capacity validation
  validate :attendees_cannot_be_higher_than_capacity, if: :capacity
  def attendees_cannot_be_higher_than_capacity
    if capacity < total_attendees
      errors.add(:capacity, I18n.t('events.message.capacity'))
    end
  end

  def total_attendees
    self.tickets.inject(0) { |result, ticket| result + ticket.attendees}
  end

  def free_capacity
    capacity - total_attendees
  end

end
