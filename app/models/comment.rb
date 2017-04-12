class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :creation

  default_scope { order(created_at: :desc) }

  validates :content, presence: true, length: {maximum: 1000}
end
