class FixMonsterTypeRelations < ActiveRecord::Migration[5.1]
  def change
        remove_column :traits, :monster_types_id
        remove_column :actions, :monster_types_id
        remove_column :legendary, :monster_types_id

        add_reference :traits, :monster_type
        add_reference :actions, :monster_type
        add_reference :legendary, :monster_type
  end
end
