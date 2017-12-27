require 'spec_helper'

feature "User follows other users" do
  scenario "User follows and unfollows another user" do
    comedies = Fabricate(:category)
    monk = Fabricate(:video, title: "Monk", category: comedies)
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    review = Fabricate(:review, user: bob, video: monk)

    sign_in(alice)

    #visit video_path(monk)
    click_on_video_on_home_page(monk)
    expect(page).to have_content(bob.name)
    expect(page).to have_content(bob.reviews.first.body)

    click_link bob.name
    expect(page).to have_content("#{bob.name}'s video collection")

    click_button "Follow"
    expect(page).to have_content("People I Follow")
    expect(page).to have_content(bob.name)

    within(:xpath, "//tr[contains(.,'#{bob.name}')]") do
      find("a[href^='/relationships']").click
    end
    expect(page).to_not have_content(bob.name)

    visit people_path
    expect(page).to_not have_content(bob.name)

    charlie = Fabricate(:user)

    visit user_path(bob)
    click_button "Follow"
    visit user_path(charlie)
    click_button "Follow"
    visit home_path
    visit people_path
    expect(page).to have_content(bob.name)
    expect(page).to have_content(charlie.name)

    within(:xpath, "//tr[contains(.,'#{charlie.name}')]") do
      find("a[href^='/relationships']").click
    end
    expect(page).to have_content(bob.name)
    expect(page).to_not have_content(charlie.name)

  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end