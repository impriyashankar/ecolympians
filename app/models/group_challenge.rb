class GroupChallenge < ApplicationRecord
  STATUSES = %w[waiting ongoing finished]
  belongs_to :challenge
  belongs_to :membership
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :start_date, presence: true

  validate :valid_start_date?

  private

  def valid_start_date?
    if start_date.nil? || start_date < Date.today
      errors.add(:start_date, "should be today or in the future")
    end
  end
end
