class Creation < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 100 }

  def self.search(query, order = "created_at DESC")
    # make a table that has usernames included with the creations
    joined = Creation.joins('INNER JOIN "users" ON "users"."id" = "creations"."user_id"').select('creations.*, users.name AS username').order(order)
    # select the creations where the search string matches either the creation name or the creator's username
    joined.where("creations.name LIKE ? OR users.name LIKE ?", "%#{query}%", "%#{query}%")
  end
end
