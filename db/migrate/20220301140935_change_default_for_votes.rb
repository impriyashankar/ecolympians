class ChangeDefaultForVotes < ActiveRecord::Migration[6.1]
  def change
    change_column :challenge_votes, :votes, :integer, default: 0
  end
end
