class MonsterStructure < ActiveRecord::Migration[5.1]
  def change
      add_column :monster_types, :size, :string
      add_column :monster_types, :type, :string
      add_column :monster_types, :alignment, :string
      add_column :monster_types, :ac, :string
      add_column :monster_types, :hp, :string
      add_column :monster_types, :speed, :string
      add_column :monster_types, :str, :integer
      add_column :monster_types, :dex, :integer
      add_column :monster_types, :con, :integer
      add_column :monster_types, :int, :integer
      add_column :monster_types, :wis, :integer
      add_column :monster_types, :cha, :integer
      add_column :monster_types, :save, :string
      add_column :monster_types, :skill, :string
      add_column :monster_types, :vulnerable, :string
      add_column :monster_types, :resist, :string
      add_column :monster_types, :immune, :string
      add_column :monster_types, :conditionimmune, :string
      add_column :monster_types, :senses, :string
      add_column :monster_types, :passive, :string
      add_column :monster_types, :languages, :string
      add_column :monster_types, :cr, :string
      add_column :monster_types, :trait, :string
      add_column :monster_types, :action, :string
  end
end
