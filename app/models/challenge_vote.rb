class ChallengeVote < ApplicationRecord
  belongs_to :potential_challenge
  belongs_to :user
  validates :user, uniqueness: { scope: :potential_challenge,
                                 message: "has already voted!" }
end
