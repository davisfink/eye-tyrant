class NewMonsterColumns < ActiveRecord::Migration[5.1]
  def change
      add_column :monster_types, :legendary, :text
      add_column :monster_types, :spells, :string
      add_column :monster_types, :slots, :string
      add_column :monster_types, :description, :string
  end
end
