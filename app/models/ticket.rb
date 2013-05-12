class Ticket < ActiveRecord::Base
  attr_accessible :attendees, :paid, :random_key, :email, :checked, :properties, :ticket_type_id
  
  belongs_to :ticket_type
  has_one :event, :through => :ticket_type
  belongs_to :user
  has_one :payment_notification
  serialize :properties, Hash

  validates_presence_of :attendees, :email
  validates :attendees, :numericality => {:greater_than => 0}
  validate :attendees_cannot_exceed_ticket_type_capacity, :if => :attendees

  def self.total_on(date)
    where("date(created_at) = ?",date).sum(:attendees)
  end

  def attendees_cannot_exceed_ticket_type_capacity
    if ticket_type.capacity < ticket_type.total_attendees + attendees
      errors.add(:attendees, I18n.t('tickets.message.exceed_capacity'))
    end
  end
  
  before_save :default_values
  def default_values
    self.random_key ||= SecureRandom.hex(16)
  end

  def paypal_url(return_url, notify_url)
    values = {
      :business => event.paypal_account,
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :notify_url => notify_url,
      :invoice => id,
      :amount_1 => ticket_type.price,
      :item_name_1 => "#{event.name} (#{ticket_type.name} tickets)",
      :item_number_1 => id,
      :quantity_1 => attendees
    }
    Rails.application.config.paypal_url + "/cgi-bin/webscr?" + values.to_query
  end
end
