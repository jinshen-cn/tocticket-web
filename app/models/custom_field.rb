class CustomField < ActiveRecord::Base
  belongs_to :event
  attr_accessible :field_type, :name, :label, :required

  validates_presence_of :field_type, :label

  FIELD_TYPES = [[I18n.t('events.custom_fields.text_field'), 'text_field'],
                 [I18n.t('events.custom_fields.check_box'), 'check_box'],
                 [I18n.t('events.custom_fields.image'), 'image']]

  after_save :default_values
  def default_values
    name = self.label.parameterize[0..10] + self.id.to_s
    update_column(:name, name)
  end
end
