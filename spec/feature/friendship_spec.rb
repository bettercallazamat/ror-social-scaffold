require_relative '../rails_helper.rb'

RSpec.describe 'Friendship', type: :feature do
  before(:all) do
    User.create(name: 'User1', email: 'user1@mail.com', password: '123123')
    User.create(name: 'User2', email: 'user2@mail.com', password: '123123')
    User.create(name: 'User3', email: 'user3@mail.com', password: '123123')
    User.create(name: 'User4', email: 'user4@mail.com', password: '123123')
    User.create(name: 'User5', email: 'user5@mail.com', password: '123123')
    User.find(1).friendships.create(friend_id: 3, confirmed: true)
    User.find(3).friendships.create(friend_id: 1, confirmed: true)
    User.find(4).friendships.create(friend_id: 1, confirmed: false)
    User.find(5).friendships.create(friend_id: 1, confirmed: false)
  end

  context 'when logged in User1' do
    before(:each) do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@mail.com'
      fill_in 'user_password', with: '123123'
      find("input[type='submit']").click
    end

    it 'sends an invitation to a new friend' do
      visit users_path
      find('li', text: 'User2').click_link('Send an invitation')
      expect(page).to have_content('Invitation sent')
    end

    it 'removes a friend' do
      visit users_path
      find('li', text: 'User3').click_link('Remove friend')
      expect(page).to have_content('Friendship removed')
    end

    context 'when accepts a friendship request' do
      before(:each) do
        visit users_path
        find('li', text: 'User4').click_link('(Accept friendship request)') 
      end

      it 'gets a message "Friendship accepted!"' do
        expect(page).to have_content('Friendship accepted!')
      end
    end
  end
end
