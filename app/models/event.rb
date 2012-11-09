class Event < ActiveRecord::Base
  attr_accessible :address, :celebrated_at, :door_payment, :info, :name, :price, :selling_deadline, :tickets_limit, :url
  belongs_to :organizer, :class_name => "User"
end
