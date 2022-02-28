class CreateChallengeVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :challenge_votes do |t|
      t.references :group, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.integer :votes

      t.timestamps
    end
  end
end
