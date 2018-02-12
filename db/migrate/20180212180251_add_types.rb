class AddTypes < ActiveRecord::Migration[5.1]
  def change
      create_table :types do |t|
          t.string :name
          t.string :race
          t.string :source
      end

      create_join_table :types, :monster_types
      remove_column :monster_types, :type
      add_reference :monster_types, :type, foreign_key: true

  end
end
