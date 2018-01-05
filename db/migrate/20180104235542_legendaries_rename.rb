class LegendariesRename < ActiveRecord::Migration[5.1]
  def change
      drop_join_table :legendary, :monster_types
      drop_table :legendary

      create_table :legendaries do |t|
          t.string :name
          t.text :text
          t.string :attack
      end
  end
end
