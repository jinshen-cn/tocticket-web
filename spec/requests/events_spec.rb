require 'spec_helper'

def create_an_event
  visit new_event_path
  event = FactoryGirl.build(:event, ticket_types: [FactoryGirl.build(:standard_type)])
  within("form#new_event") do
    fill_in "event_name", with: event.name
    fill_in "event_formatted_celebrated_at", with: event.formatted_celebrated_at
    fill_in "event_address", with: event.address
    fill_in "event_ticket_types_attributes_0_price", with: event.ticket_types[0].price
    fill_in "event_ticket_types_attributes_0_capacity", with: event.ticket_types[0].capacity
    click_button "Create Event"
  end
end

describe "Events" do
  before :each  do
    login_as_organizer
    create_an_event
  end
  it "allows create a new event" do
    page.should have_content("Madrid-Atleti Football match")
  end
  it "allows list events when created" do
    visit events_path
    page.should have_content("Madrid-Atleti Football match")
  end
  it "allows edit events when created" do
    visit events_path
    find('.icon-edit').find(:xpath,".//..").click

    fill_in "event_name", with: "New name"
    first(".btn").click

    page.should have_content("Event was successfully updated.")
    page.should have_content("New name")
  end
  it "allows delete events when created" do
    visit events_path
    find('.icon-trash').find(:xpath,".//..").click
    page.should_not have_content("Madrid-Atleti Football match")
  end
end
