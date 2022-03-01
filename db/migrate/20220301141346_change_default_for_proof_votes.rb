class ChangeDefaultForProofVotes < ActiveRecord::Migration[6.1]
  def change
    change_column :group_challenges, :votes, :integer, default: 0
  end
end
