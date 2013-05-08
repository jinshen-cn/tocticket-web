# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :custom_field do
    name "MyString"
    field_type "MyString"
    required false
    event nil
  end
end
