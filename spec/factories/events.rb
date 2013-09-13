# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Madrid-Atleti Football match"
    formatted_celebrated_at "09/11/2020 12:00 am"
    address "Bernabeu Stadium"
  end
  factory :ticket_type, aliases: [:standard_type] do
    price "104"
    capacity "10000"
  end
end
