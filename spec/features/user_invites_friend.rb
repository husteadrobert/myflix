require 'spec_helper'

feature "User invites another user" do
  background do
    clear_emails
  end
  scenario "invited person follows the link" do
    alice = Fabricate(:user)
    sign_in(alice)
    visit new_invitation_path
    fill_in "Friend's Name", with: "John Smith"
    fill_in "Friend's Email Address", with: "abc@abc.com"
    fill_in "invitation_message", with: "Join this site."
    click_button "Send Invitation"
    sign_out

    open_email("abc@abc.com")
    expect(current_email).to have_content("Join this site.")
    current_email.click_link "Come Join Today!"
    expect(find_field("Email address").value).to eq("abc@abc.com")

    fill_in "Password", with: "password"
    fill_in "Name", with: "John Doe"
    click_button "Sign Up"
    
    visit login_path
    fill_in "email_address", with: "abc@abc.com"
    fill_in "password", with: "password"
    click_button "Sign In"

    expect(page).to have_content("John Doe")

    visit people_path

    expect(page).to have_content(alice.name)

    sign_out

    sign_in(alice)
    visit people_path

    expect(page).to have_content("John Doe")

    clear_emails
  end


end