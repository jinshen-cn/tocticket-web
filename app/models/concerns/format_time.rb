module FormatTime
  extend ActiveSupport::Concern
    module ClassMethods
      def formatted_time_accessor(*names)
        names.each do |name|
          attr_accessible "formatted_#{name}"
          define_method("formatted_#{name}") do
            self[name].strftime(I18n.t('time.formats.default')) if self[name]
          end
          define_method("formatted_#{name}=") do |value|
            self[name] = DateTime.strptime(value, I18n.t('time.formats.default'))
          end
        end
      end
    end
end