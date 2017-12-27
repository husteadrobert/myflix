def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def sign_in(user=nil)
  user ||= Fabricate(:user)
  visit login_path
  fill_in "email_address", with: user.email_address
  fill_in 'password', with: user.password
  click_button 'Sign In'
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end
