class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.integer :score
      t.string :category

      t.timestamps
    end
  end
end
