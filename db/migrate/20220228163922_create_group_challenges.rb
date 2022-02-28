class CreateGroupChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :group_challenges do |t|
      t.string :comment
      t.integer :votes
      t.string :status
      t.date :start_date
      t.references :challenge, null: false, foreign_key: true
      t.references :membership, null: false, foreign_key: true

      t.timestamps
    end
  end
end
