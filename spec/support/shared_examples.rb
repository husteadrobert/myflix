shared_examples "requires sign in" do
  it "redirects to login page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "tokenable" do
  it "generates a random token when the object is created" do
    expect(object.token).to be_present
  end
end

shared_examples "requires admin" do
  it "redirects to home path" do
    set_current_user
    action
    expect(response).to redirect_to home_path
  end
end