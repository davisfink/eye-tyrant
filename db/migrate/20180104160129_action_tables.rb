class ActionTables < ActiveRecord::Migration[5.1]
  def change
      create_table :actions do |t|
          t.string :name
          t.text :text
          t.string :attack
      end

      create_table :legendary do |t|
          t.string :name
          t.text :text
          t.string :attack
      end
  end
end
