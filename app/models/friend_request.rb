class FriendRequest < ApplicationRecord
  belongs_to :from_user, class_name: :User, foreign_key: :requestor_id
  belongs_to :to_user,   class_name: :User, foreign_key: :requested_id
  scope      :accepted, -> { where(accepted: true) }
  scope      :pending,  -> { where(accepted: nil) }

  validates :requestor_id, presence: true
  validates :requested_id, presence: true
  
  def FriendRequest.friendships(user)
    where(requestor_id: user.id).accepted
  end
end
