class Creation < ApplicationRecord
  belongs_to :user
  has_many :comments

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 100 }
end
