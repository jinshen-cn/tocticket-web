class VideoPrint < ActiveRecord::Base
  belongs_to :ticket
  has_one :event, :through => :ticket
end
