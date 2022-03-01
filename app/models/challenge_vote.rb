class ChallengeVote < ApplicationRecord
  belongs_to :group
  belongs_to :challenge
  validates :votes, presence: true
  has_one_attached :photo
end
