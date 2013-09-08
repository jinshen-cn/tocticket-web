require "spec_helper"

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit root_path
    within("form[action='/users']") do
      fill_in "user_name",                  :with => "Alinde Man"
      fill_in "Email",                      :with => "alindeman@example.com"
      fill_in "Password",                   :with => "ilovegrapes"
      fill_in "user_password_confirmation", :with => "ilovegrapes"
      click_button "Sign up"
    end
    #save_and_open_page
    page.should have_content('Welcome! You have signed up successfully.')
  end
end