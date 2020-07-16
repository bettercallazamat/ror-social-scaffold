class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User', foreign_key: 'user_id'

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :confirmed_friends, through: :confirmed_friendships, source: :friend, foreign_key: 'user_id'

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship'
  has_many :pending_friends, through: :pending_friendships, source: :friend, foreign_key: 'friend_id'

  has_many :friendship_requests, -> { where confirmed: false }, class_name: 'Friendship'
  has_many :requesting_friends, through: :friendship_requests, source: :user, foreign_key: 'user_id'

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user, foreign_key: 'user_id'

  # Users who have requested to be friends
  def friend_request?(id)
    inverse_friendships.where(user_id: id).any?
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |lfriendship| lfriendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    return true if friends.find(user.id)

    false
  end
end
