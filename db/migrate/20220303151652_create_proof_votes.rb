class CreateProofVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :proof_votes do |t|
      t.references :group_challenge, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :vote

      t.timestamps
    end
  end
end
