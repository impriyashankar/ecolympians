class ChallengeVote < ApplicationRecord
  belongs_to :group
  belongs_to :challenge
end
