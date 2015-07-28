require "rails_helper"

RSpec.feature "User logs out", :type => :feature do
  let(:username) { "test_user" }
  let(:password) { "password" }

  before do
    #TODO: find a better way to log user in
    User.create(name: "Test User", username: username, password: password)
    visit login_path

    fill_in "Username", :with => username
    fill_in "Password", :with => password
    click_button "Log in"
  end

  scenario "from users#index" do
    visit root_path
    click_link "Log Out"
    expect(page).to have_text("Log In")
  end
end

