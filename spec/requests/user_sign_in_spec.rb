require "spec_helper"

describe "user sign in" do
  it "allows users to sign in after they have registered" do
    user = User.create(email:    "alindeman@example.com",
                       password: "ilovegrapes",
                       role:     "organizer")

    visit root_path
    within("form[action='/users/sign_in']") do
      fill_in "Email",    with: user.email
      fill_in "Password", with: "ilovegrapes"

      click_button "Sign in"
    end
    page.should have_content('Signed in successfully.')

  end
end