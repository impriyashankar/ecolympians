class RemoveVotesFromGroupChallenges < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_challenges, :votes, :string
  end
end
