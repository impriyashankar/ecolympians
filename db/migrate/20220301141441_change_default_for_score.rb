class ChangeDefaultForScore < ActiveRecord::Migration[6.1]
  def change
    change_column :memberships, :score, :integer, default: 0
  end
end
