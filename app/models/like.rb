class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, class_name: :Post, foreign_key: :content_id
end
