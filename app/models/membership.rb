class Membership < ApplicationRecord
  MEMBER_STATUSES = %w[Pending Accepted Declined]

  belongs_to :user
  belongs_to :group
  has_many :group_challenges, dependent: :destroy
  validates :role, presence: true, inclusion: { in: ['Member', 'Admin'] }
  validates :status, presence: true, inclusion: { in: MEMBER_STATUSES }

  def update_vote
    @group = group
    @group_challenges = GroupChallenge.where(membership: self, group: @group)

    if @group_challenge.status == "finished"
      @group_challenges.each do |group_challenge|
        score = group_challenge.challenge.score
        votes = ProofVote.where(group_challenge_id: group_challenge.id, user_id: user_id)
        pos = votes.where(vote: true).count
        neg = votes.where(vote: false).count

        if pos >= neg
          udpate(score: score + score)
        end
      end
      # @membership.score += @group_challenge.challenge.score
    end
  end


  #validates :user_id, uniqueness: { scope: :group_id } # Each user id-group id combination should be unique
end
