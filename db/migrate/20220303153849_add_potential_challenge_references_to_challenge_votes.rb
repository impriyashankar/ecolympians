class AddPotentialChallengeReferencesToChallengeVotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :challenge_votes, :potential_challenge, null: false, foreign_key: true
  end
end
