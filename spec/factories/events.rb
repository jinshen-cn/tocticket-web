# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    date "2012-11-09 03:05:59"
    address "MyText"
    price "9.99"
    info "MyText"
    url "MyString"
    selling_deadline "2012-11-09 03:05:59"
    tickets_limit 1
    door_payment false
  end
end
