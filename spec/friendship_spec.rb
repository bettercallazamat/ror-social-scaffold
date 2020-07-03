require_relative './rails_helper.rb'

RSpec.describe 'Friendship', type: :feature do
  before(:all) do
    visit new_user_registration_path
    fill_in 'user_name', with: 'johnsmith1'
    fill_in 'user_email', with: 'johnsmith1'
    fill_in 'user_password', with: 'passwordexample'
    fill_in 'user_password_confirmation', with: 'passwordexample'
    find("input[type='submit']").click
    click_on 'Sign out'
    visit new_user_registration_path
    fill_in 'user_name', with: 'johnsmith2'
    fill_in 'user_email', with: 'johnsmith2'
    fill_in 'user_password', with: 'passwordexample'
    fill_in 'user_password_confirmation', with: 'passwordexample'
    find("input[type='submit']").click
  end

  it 'should send Friendship requests' do
    visit users_path
    find_link("send-invitation-link").click
    expect(page).to have_content('Invitation sent')
  end

  it 'should accept Friendship requests' do
    visit new_user_session_path
    fill_in 'user_email', with: 'johnsmith1'
    fill_in 'user_password', with: 'passwordexample'
    visit users_path
    find_link("accept-invitation-link").click
    expect(page).to have_content('Friendship accepted!')
  end
end
