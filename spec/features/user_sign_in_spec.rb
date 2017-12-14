require 'spec_helper'

feature "Signing In" do
  background do
    #Fabricate(:user, email_address: "test@test.com", password: "test", name: "John Doe")
  end

  scenario "Sign in with correct credentials" do
    #visit '/login'
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content(alice.name)
  end
end