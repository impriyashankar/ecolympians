class PotentialChallenge < ApplicationRecord
  belongs_to :group
  belongs_to :challenge
  has_many :challenge_votes, dependent: :destroy

  def votes
    challenge_votes.count
  end

end
