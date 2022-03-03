class RemoveChallengeVoteFromChallengeVotes < ActiveRecord::Migration[6.1]
  def change
    remove_reference :user_votes, :challenge_vote, null: false, foreign_key: true
  end
end
