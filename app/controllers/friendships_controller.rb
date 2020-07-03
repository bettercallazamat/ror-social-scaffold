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
end
