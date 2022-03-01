class Group < ApplicationRecord
  has_many :memberships
  has_many :challenge_votes
  validates :name, presence: true
end
