class UpdateChallengeRatings < ActiveRecord::Migration[5.1]
  def change
      rename_column :challenge_ratings, :hard, :deadly
      rename_column :challenge_ratings, :challenging, :hard
  end
end
