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
    friendship1 = Friendship.where(user_id: params[:id], friend_id: current_user.id)[0]
    friendship1.update(confirmed: true)
    friendship2 = Friendship.create(user_id: current_user.id, friend_id: params[:id], confirmed: true)

    if friendship
      flash[:notice] = 'Friendship accepted!'
    else
      flash[:alert] = 'It was not possible to accept this friendship. Try again later.'
    end

    redirect_to users_path
  end

  def destroy
    friendship1 = Friendship.where(user_id: current_user.id, friend_id: params[:id])[0]
    friendship1 = Friendship.where(user_id: params[:id], friend_id: current_user.id)[0]
    if friendship1 && friendship2
      friendship1.destroy
      friendship2.destroy
      flash[:notice] = 'Friendship removed'
    else
      flash[:alert] = 'It was not possible to remove this friendship. Try again later.'
    end
    redirect_to users_path
  end

  def destroy2
    friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id)[0]
    if friendship
      friendship.destroy
      flash[:notice] = 'Friendship rejected'
    else
      flash[:alert] = 'It was not possible to reject this friendship. Try again later.'
    end
    redirect_to users_path
  end
end
