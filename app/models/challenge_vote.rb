class ChallengeVote < ApplicationRecord
  belongs_to :potential_challenge
  belongs_to :user
  validates :vote, presence: true
end
