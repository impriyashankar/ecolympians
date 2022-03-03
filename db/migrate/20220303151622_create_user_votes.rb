class CreateUserVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_votes do |t|
      t.references :challenge_vote, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :vote

      t.timestamps
    end
  end
end
