class ProofVote < ApplicationRecord
  belongs_to :group_challenge
  belongs_to :user
  validates :vote, presence: true
end
