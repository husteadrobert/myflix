require 'spec_helper'

feature "User resets password" do
  background do
    clear_emails
    visit forgot_password_path
  end
  scenario "user is registered" do
    alice = Fabricate(:user)
    fill_in "email", with: alice.email_address
    click_button "Send Email"
    open_email(alice.email_address)

    expect(current_email).to have_content("Reset My Password")

    current_email.click_link "Reset My Password"
    expect(page).to have_content("New Password")

    fill_in "password", with: "12345"
    click_button "Reset Password"
    expect(page).to have_content("Sign In")

    fill_in "email_address", with: alice.email_address
    fill_in "password", with: "12345"
    click_button "Sign In"
    expect(page).to have_content(alice.name)
  end
  scenario "user is not registered" do
    fill_in "email", with: "lolwhat@what.com"
    click_button "Send Email"
    expect(page).to have_content("system")
  end
end