class TicketType < ActiveRecord::Base
  attr_accessible :capacity, :name, :price
  belongs_to :event
  has_many :tickets
end
