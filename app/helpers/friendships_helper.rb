# rubocop:disable Layout/LineLength
module FriendshipsHelper
  def friendship_status(user)
    return nil unless current_user.id != user.id

    if current_user.friends.include?(user)
      link_to 'Remove friend', unfriendship_path(user), method: :delete, id: 'unfriendship-link', class: 'profile-link'
    elsif current_user.pending_friends.include?(user)
      content = "<span class = 'profile-link'>Invitation pending...</span>"
      content.html_safe
    elsif current_user.friend_request?(user.id)
      content = ''
      content += link_to 'Accept friendship request', friendship_path(user.id), method: :put, id: 'accept-invitation-link', class: 'profile-link'
      content += link_to 'Reject friendship request', reject_friendship_path(user.id), method: :delete, id: 'reject-invitation-link', class: 'profile-link'
      content.html_safe
    else
      link_to 'Send an invitation', new_friendship_path(user), method: :post, id: 'send-invitation-link', class: 'profile-link'
    end
  end
end
# rubocop:enable Layout/LineLength
