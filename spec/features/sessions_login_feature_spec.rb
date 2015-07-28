require "rails_helper"

RSpec.feature "User logs in", :type => :feature do
  let(:username) { "test_user" }
  let(:password) { "password" }

  before do
    User.create(name: "Test User", username: username, password: password)
  end

  scenario "with invalid username/password" do
    visit login_path

    fill_in "Username", :with => username + "!"
    fill_in "Password", :with => password + "!"
    click_button "Log in"

    expect(page).to have_text("Log in")
  end

  scenario "with invalid password" do
    visit login_path

    fill_in "Username", :with => username
    fill_in "Password", :with => password + "!"
    click_button "Log in"

    expect(page).to have_text("Log in")
  end

  scenario "with valid username and password" do
    visit login_path

    fill_in "Username", :with => username
    fill_in "Password", :with => password
    click_button "Log in"

    expect(page).to have_text("Log Out")
  end
end
