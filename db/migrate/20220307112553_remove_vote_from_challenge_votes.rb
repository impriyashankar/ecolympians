class RemoveVoteFromChallengeVotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :challenge_votes, :vote, :boolean
  end
end
