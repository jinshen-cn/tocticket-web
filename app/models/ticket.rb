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
  validate :validate_properties

  def validate_properties
    event.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, I18n.t('tickets.message.not_blank')
      end
    end
  end

  def self.total_on(date)
    where("date(created_at) = ?",date).sum(:attendees)
  end

  def attendees_cannot_exceed_ticket_type_capacity
    if ticket_type.capacity < ticket_type.total_attendees + attendees
      errors.add(:attendees, I18n.t('tickets.message.exceed_capacity', free_capacity: ticket_type.free_capacity))
    end
  end
  
  before_save :default_values, :process_image_custom_fields
  def default_values
    self.random_key ||= SecureRandom.hex(16)
  end
  def process_image_custom_fields
    self.properties.each do |key, value|
      type = self.event.fields.find_by_name(key).field_type
      if type == "image"
        image = ImageField.new(image: self.properties[key])
        image.save!
        self.properties[key] = image.id
      end
    end
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
