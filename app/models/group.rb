class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :group_challenges
  has_many :challenge_votes
  validates :name, presence: true
end
