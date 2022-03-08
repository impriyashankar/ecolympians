class Membership < ApplicationRecord
  MEMBER_STATUSES = %w[Pending Accepted Declined]

  belongs_to :user
  belongs_to :group
  has_many :group_challenges, dependent: :destroy
  validates :role, presence: true, inclusion: { in: ['Member', 'Admin'] }
  validates :status, presence: true, inclusion: { in: MEMBER_STATUSES }

  def update_score
    @group = group
    @group_challenges = GroupChallenge.where(membership: self, group: @group)
      # group.group_challenges.where(start_date:, status: "ongoing")
    @group_challenges.each do |group_challenge|
      unless group_challenge.status == "finished"
        group_challenge.status = "finished"
        group_challenge.membership.score += group_challenge.challenge.score
        group_challenge.save
      end
    end
  end

  #validates :user_id, uniqueness: { scope: :group_id } # Each user id-group id combination should be unique
end
