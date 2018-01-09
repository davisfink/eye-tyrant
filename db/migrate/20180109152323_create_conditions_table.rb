class CreateConditionsTable < ActiveRecord::Migration[5.1]
  def change
      create_table :conditions do |t|
          t.string :name
          t.text :description, array: true
      end
  end
end
