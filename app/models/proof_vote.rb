class ProofVote < ApplicationRecord
  belongs_to :group_challenge
  belongs_to :user
  validates :user, uniqueness: { scope: :group_challenge, message: "has already voted!" }
  validates :vote, inclusion: { in: [true, false] }
end
