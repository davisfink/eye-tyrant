class CreateRaceTable < ActiveRecord::Migration[5.1]
  def change
      create_table :races do |t|
          t.string :name
          t.string :size
          t.string :speed
          t.string :ability
          t.string :proficiency
      end
    create_join_table :races, :traits
    remove_column :characters, :race
    add_reference :characters, :races, foreign_key: true
  end
end
