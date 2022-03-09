class Challenge < ApplicationRecord
  CATEGORIES = %w[
    Recycle
    Planting\ trees
    Pick\ up\ trash
    Made\ homemade\ art
    Conserving\ water
    Preventing\ pollution
    Reuse\ items
    Saving\ energy
    Travel
    Food
  ]
  has_many :group_challenges, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :score, presence: true, numericality: { less_than_or_equal_to: 300 }

  include PgSearch::Model
  pg_search_scope :search_by_score_category_name,
    against: [ :name, :category, :score ],
    using: {
      tsearch: { prefix: true }
    }
end
