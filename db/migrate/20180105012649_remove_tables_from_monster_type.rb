class RemoveTablesFromMonsterType < ActiveRecord::Migration[5.1]
  def change
      remove_column :monster_types, :trait
      remove_column :monster_types, :spells
  end
end
