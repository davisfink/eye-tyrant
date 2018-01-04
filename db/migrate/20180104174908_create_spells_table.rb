class CreateSpellsTable < ActiveRecord::Migration[5.1]
  def change
      create_table :spells do |t|
          t.string :name
          t.string :school
          t.string :time
          t.string :range
          t.string :components
          t.string :duration
          t.text :classes
          t.text :text, array: true
          t.text :roll, array: true
      end
  end
end
