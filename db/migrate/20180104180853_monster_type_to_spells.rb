class MonsterTypeToSpells < ActiveRecord::Migration[5.1]
  def change
      create_join_table :monster_types, :spells
  end
end
