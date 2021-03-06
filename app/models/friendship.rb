class Friendship < ApplicationRecord
  validate :not_self_friendship
  validates :user_id, uniqueness: { scope: :friend_id }

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  def not_self_friendship
    errors.add(:friend_id, 'User can not send a self friendship request.') if user_id == friend_id
  end

  def confirm_friendship
    update(confirmed: true)
    Friendship.create(user_id: friend_id, friend_id: user_id, confirmed: true)
  end

  def remove_friendship
    destroy
    friendship = Friendship.where(user_id: friend_id, friend_id: user_id, confirmed: true)[0]
    friendship.destroy
  end
end
