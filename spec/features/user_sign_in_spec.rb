require 'spec_helper'

feature "Signing In" do
  background do
    Fabricate(:user, email_address: "test@test.com", password: "test", name: "John Doe")
  end

  scenario "Sign in with correct credentials" do
    #visit '/login'
    visit login_path
    fill_in "email_address", with: "test@test.com"
    fill_in 'password', with: "test"
    click_button 'Sign In'
    expect(page).to have_content("John Doe")
  end
end