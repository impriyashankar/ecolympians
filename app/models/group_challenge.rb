class GroupChallenge < ApplicationRecord
  belongs_to :challenge
  belongs_to :membership
end
