require 'spec_helper'

feature "User invites another user" do
  background do
    clear_emails
  end
  scenario "invited person follows the link" do
    alice = Fabricate(:user)
    sign_in(alice)

    invite_a_friend
    friend_accepts_invite
    friend_signs_in
    expect(page).to have_content("John Doe")
    friend_should_follow(alice)
    sign_out
    sign_in(alice)
    inviter_should_follow_friend("John Doe")
    sign_out
    current_email.click_link "Come Join Today!"
    expect(page).to have_content("expired")

    clear_emails
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "John Smith"
    fill_in "Friend's Email Address", with: "abc@abc.com"
    fill_in "invitation_message", with: "Join this site."
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invite
    open_email("abc@abc.com")
    expect(current_email).to have_content("Join this site.")
    current_email.click_link "Come Join Today!"
    expect(find_field("Email address").value).to eq("abc@abc.com")
    expect(page).to have_selector("input[value='abc@abc.com']")

    fill_in "Password", with: "password"
    fill_in "Name", with: "John Doe"
    click_button "Sign Up"
  end

  def friend_signs_in
    visit login_path
    fill_in "email_address", with: "abc@abc.com"
    fill_in "password", with: "password"
    click_button "Sign In"
  end

  def friend_should_follow(user)
    visit people_path
    expect(page).to have_content(user.name)
  end

  def inviter_should_follow_friend(name)
    visit people_path
    expect(page).to have_content(name)
  end
end