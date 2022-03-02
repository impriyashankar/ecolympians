class Challenge < ApplicationRecord
  CATEGORIES = %w[
    Recycle
    Planting\ tree
    Pick\ up\ trash
    Made\ homemade\ art
    Conserving\ water
    Preventing\ pollution
    Reuse\ items
    Saving\ energy
    Travel
    Food
  ]
  has_many :challange_votes
  has_many :group_challenges, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :score, presence: true
end
