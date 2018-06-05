class Post < ApplicationRecord
  belongs_to :user
  has_many   :likes
  has_many   :comments
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
end
