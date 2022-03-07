class PotentialChallenge < ApplicationRecord
  belongs_to :group
  belongs_to :challenge
  has_many :challenge_votes

  def votes
    challenge_votes.count
  end
end
