class CustomField < ActiveRecord::Base
  belongs_to :event
  attr_accessible :field_type, :name, :required

  validates_presence_of :field_type, :name

  FIELD_TYPES = [[I18n.t('events.custom_fields.text_field'), 'text_field'],
                 [I18n.t('events.custom_fields.check_box'), 'check_box'],
                 [I18n.t('events.custom_fields.image'), 'image']]
end
