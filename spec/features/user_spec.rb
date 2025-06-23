require 'rails_helper'

RSpec.feature "UserAuthentications", type: :feature do
  let!(:user) { create(:user) }

  scenario "User signs up successfully" do
    visit new_user_registration_path
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "passw0rd"
    fill_in "Password confirmation", with: "passw0rd"
    fill_in "Display name", with: "New User"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_current_path(root_path)
  end

  scenario "with invalid email" do
    visit new_user_session_path

    fill_in "Email", with: "wrong@example.com"
    fill_in "Password", with: user.password
    click_button "Log in"

    # Assertions for failed sign-in
    expect(page).to have_current_path(new_user_session_path) # Should stay on the login page
    expect(page).to have_content "Invalid Email or password." # Devise default error message
    expect(page).to_not have_link "Log out" # Should not be logged in
  end

  scenario "with invalid password" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Log in"

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content "Invalid Email or password."
    expect(page).to_not have_link "Log out"
  end

  xscenario "User can login and logout successfully" do
    # Login
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
    page

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Welcome, #{user.display_name}")

    # # # Logout
    click_button "Sign out"
    expect(page).to have_current_path(new_user_session_path)
  end
end
