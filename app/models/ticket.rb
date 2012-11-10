class Ticket < ActiveRecord::Base
  attr_accessible :attendees, :random_key
  
  belongs_to :event
  belongs_to :user
end
