class Membership < ApplicationRecord
  MEMBER_STATUSES = %w[Pending Accepted Declined]

  belongs_to :user
  belongs_to :group
  has_many :group_challenges, dependent: :destroy
  validates :role, presence: true, inclusion: { in: ['Member', 'Admin'] }
  validates :status, presence: true, inclusion: { in: MEMBER_STATUSES }
  #validates :user_id, uniqueness: { scope: :group_id } # Each user id-group id combination should be unique
end
