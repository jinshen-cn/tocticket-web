# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "alindeman@example.com"
    password "ilovegrapes"
    role "organizer"
  end
end
