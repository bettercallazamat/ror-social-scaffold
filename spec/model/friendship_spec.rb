require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  it 'It fails if you try to create a self friendship request' do
    f = Friendship.new
    f.user_id = 1
    f.friend_id = 1

    expect(f).to_not be_valid
  end
end
