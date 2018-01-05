class AddManyToManyForActionsLegendaryTraits < ActiveRecord::Migration[5.1]
  def change
      create_join_table :monster_types, :actions
      create_join_table :monster_types, :traits
      create_join_table :monster_types, :legendary
  end
end
