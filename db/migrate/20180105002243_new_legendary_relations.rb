class NewLegendaryRelations < ActiveRecord::Migration[5.1]
  def change
      create_join_table :legendaries, :monster_types
  end
end
