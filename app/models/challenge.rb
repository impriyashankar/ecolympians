class Challenge < ApplicationRecord
  CATEGORY = %w[
    Recycle
    Planting\ tree
    Pick\ up\ trash
    Made\ homemade\ art
    Conserving\ water
    Preventing\ popullion
    Reuse\ items
    Saving\ energy
  ]
  has_many :challange_votes
  has_many :group_challenges
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :score, presence: true
end
