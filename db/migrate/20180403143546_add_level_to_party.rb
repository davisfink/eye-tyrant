class AddLevelToParty < ActiveRecord::Migration[5.1]
  def change
      add_column :parties, :level, :integer
  end
end
