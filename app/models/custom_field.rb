class CustomField < ActiveRecord::Base
  belongs_to :event
  attr_accessible :field_type, :name, :required
end
