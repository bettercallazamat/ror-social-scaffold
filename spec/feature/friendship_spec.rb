require_relative '../rails_helper.rb'

RSpec.describe 'Friendship', type: :feature do
  before(:all) do
    User.create(name: 'User1', email: 'user1@mail.com', password: '123123')
    User.create(name: 'User2', email: 'user2@mail.com', password: '123123')
    User.create(name: 'User3', email: 'user3@mail.com', password: '123123')
    User.create(name: 'User4', email: 'user4@mail.com', password: '123123')
    User.find(1).friendships.create(friend_id: 3, confirmed: true)
    User.find(3).friendships.create(friend_id: 1, confirmed: true)
    User.find(4).friendships.create(friend_id: 1, confirmed: false)
  end

  context 'when logged in as User1' do
    before(:each) do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@mail.com'
      fill_in 'user_password', with: '123123'
      find("input[type='submit']").click
      visit users_path
    end

    it 'sends an invitation to a new friend' do
      # visit users_path
      find('li', text: 'User2').click_link('Send an invitation')
      expect(page).to have_content('Invitation sent')
    end

    it 'removes a friend' do
      # visit users_path
      find('li', text: 'User3').click_link('Remove friend')
      expect(page).to have_content('Friendship removed')
    end

    it 'accepts friendship and creates mutual friendship' do
      # visit users_path
      click_link('Accept friendship request')
      expect(page).to have_content('Friendship accepted!')

      user1 = User.find(1)
      user2 = User.find(4)
      expect(user1.friend?(user2)).to be true
      expect(user2.friend?(user1)).to be true
    end
  end
end
