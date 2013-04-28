# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket_type do
    name "MyString"
    price "9.99"
    capacity 1
  end
end
