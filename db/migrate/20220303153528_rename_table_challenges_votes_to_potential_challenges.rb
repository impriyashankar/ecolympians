class RenameTableChallengesVotesToPotentialChallenges < ActiveRecord::Migration[6.1]
  def change
    rename_table :challenge_votes, :potential_challenges
    rename_table :user_votes, :challenge_votes
  end
end
