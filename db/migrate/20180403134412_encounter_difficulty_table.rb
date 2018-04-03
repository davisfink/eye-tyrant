class EncounterDifficultyTable < ActiveRecord::Migration[5.1]
  def change
      create_table :challenge_ratings do |t|
          t.integer :level
          t.integer :easy
          t.integer :medium
          t.integer :challenging
          t.integer :hard
      end
  end
end
