class AddChallengeMultiplier < ActiveRecord::Migration[5.1]
  def change
      create_table :challenge_multipliers do |t|
          t.integer :value
          t.float :multiplier
      end
  end
end
