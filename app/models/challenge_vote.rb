class ChallengeVote < ApplicationRecord
  belongs_to :potential_challenge
  belongs_to :user
  validates :vote, presence: true

  def create
    @potential_challenge = PotentialChallenge.find(params[;potential_challenge_id])
  end
end
