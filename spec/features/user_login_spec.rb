require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  # SETUP
  before :each do
    @user = User.create(name: "Trent Pfeiffer", email: "trentpf@hotmail.com", password: "jungle", password_confirmation: "jungle")
  end

  scenario "They can login with valid and existing login details" do
    # ACT
    visit root_path

    # DEBUG / VERIFY

    click_on 'Login'
    fill_in 'email', with: 'trentpf@hotmail.com'
    fill_in 'password', with: 'jungle'
    click_button 'Submit'

    save_screenshot
  end
end
