# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    random_key "MyString"
    attendees 1
  end
end
