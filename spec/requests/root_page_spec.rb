require "spec_helper"

describe "Root page" do
  it "allows new organizers to register with an email and password" do
    visit root_path
    within("form[action='/users']") do
      fill_in "user_name",                  :with => "Alinde Man"
      fill_in "Email",                      :with => "some2@example.com"
      fill_in "Password",                   :with => "ilovegrapes"
      fill_in "user_password_confirmation", :with => "ilovegrapes"
      click_button "Sign up"
    end
    #save_and_open_page
    page.should have_content('Welcome! You have signed up successfully.')
  end

  it "allows organizers to sign in" do
    login_as_organizer
    page.should have_content('Signed in successfully.')

  end
end