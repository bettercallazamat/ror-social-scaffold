class FriendshipsController < ApplicationController
  def new; end

  def create
    user = User.find(current_user.id)
    friendship = user.friendships.new(user_id: current_user.id, friend_id: params[:id], confirmed: false)

    if user.inverse_friendships.where(user_id: params[:id]).none? && friendship.save
      flash[:notice] = 'Invitation sent'
    else
      flash[:alert] = 'Invitation failed'
    end

    redirect_to users_path
  end

  def update
    friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id)[0]
    friendship.update(confirmed: true)

    if friendship
      flash[:notice] = 'Friendship accepted!'
    else
      flash[:alert] = 'It was not possible to accept this friendship. Try again later.'
    end

    redirect_to users_path
  end
end
