class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :sent_requests,     class_name: :FriendRequest, foreign_key: :requestor_id
  has_many :received_requests, class_name: :FriendRequest, foreign_key: :requested_id
  has_many :posts
  has_many :likes
  has_many :comments

  def friends
    User.where(id: FriendRequest.friendships(self).pluck(:requested_id))
  end

  def request_pending?(user)
    !self.received_requests.pending.find_by(requestor_id: user.id).nil?
  end

  def sent_request?(user)
    !self.sent_requests.find_by(requested_id: user.id).nil?
  end

  def get_friend_request(user)
    FriendRequest.find_by(requestor_id: id, requested_id: user.id)
  end

  def feed
    friend_ids = "SELECT requested_id FROM friend_requests
                  WHERE  requestor_id = :user_id and accepted = true"
    Post.where("user_id IN (#{friend_ids})
               OR user_id = :user_id", user_id: id)
  end

  def liked?(post)
    Like.find_by(user_id: id, post_id: post.id).nil?
  end

  def like(post)
    Like.find_by(user_id: id, post_id: post.id)
  end
end
