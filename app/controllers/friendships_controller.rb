class FriendshipsController < ApplicationController
  def new; end

  def create
    friendship = current_user.friendships.new(friend_id: params[:id], confirmed: false)
    # friendship = current_user.friendships.build(friend_id: params[:id], confirmed: false)

    if current_user.inverse_friendships.where(user_id: params[:id]).none? && friendship.save
      flash[:notice] = 'Invitation sent'
    else
      flash[:alert] = 'Invitation failed'
    end

    redirect_to users_path
  end

  def update
    friendship1 = current_user.inverse_friendships.where(user_id: params[:id])[0]
    friendship2 = friendship1.confirm_friendship

    if friendship1 && friendship2
      flash[:notice] = 'Friendship accepted!'
    else
      flash[:alert] = 'It was not possible to accept this friendship. Try again later.'
    end

    redirect_to users_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id])[0]
    friendship.remove_friendship
    if friendship
      flash[:notice] = 'Friendship removed'
    else
      flash[:alert] = 'It was not possible to remove this friendship. Try again later.'
    end
    redirect_to users_path
  end

  def destroy2
    friendship = current_user.inverse_friendships.where(user_id: params[:id])[0]
    if friendship
      friendship.destroy
      flash[:notice] = 'Friendship rejected'
    else
      flash[:alert] = 'It was not possible to reject this friendship. Try again later.'
    end
    redirect_to users_path
  end
end
