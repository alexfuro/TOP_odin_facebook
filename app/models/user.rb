class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :sent_requests,     class_name: :FriendRequest, foreign_key: :requestor_id
  has_many :received_requests, class_name: :FriendRequest, foreign_key: :requested_id

  def friends
    FriendRequest.friendships(self)
  end
end
