class ModifyMonsterTypeTable < ActiveRecord::Migration[5.1]
  def change
      remove_column :monster_types, :legendary
      remove_column :monster_types, :action
  end

  def change
      add_reference :monster_types, :actions, index: true
      add_reference :monster_types, :legendary, index: true
  end

end
