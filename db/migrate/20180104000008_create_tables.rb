class CreateTables < ActiveRecord::Migration[5.1]
  def change

      create_table :encounters_participants do |t|
          t.integer :encounter_id
          t.integer :participant_id
      end

      create_table :participants do |t|
          t.integer :damage
          t.integer :hitpoints
          t.integer :initiative
      end

      create_table :parties do |t|
          t.string :name
          t.boolean :active
      end

      create_table :monsters do |t|
          t.integer :participant_id
          t.string :name
          t.integer :monster_type_id
      end

      create_table :experience do |t|
          t.string :cr
          t.integer :xp
      end

      create_table :characters do |t|
          t.integer :participant_id
          t.string :name
          t.string :race
          t.integer :party_id
      end

      create_table :monster_types do |t|
          t.string :name
      end
  end
end
