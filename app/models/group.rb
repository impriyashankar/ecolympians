class Group < ApplicationRecord
  has_many :users, through: :memberships
  has_many :challenge_votes
  validates :name, presence: true
end
