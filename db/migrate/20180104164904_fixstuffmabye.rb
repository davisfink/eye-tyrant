class Fixstuffmabye < ActiveRecord::Migration[5.1]
  def change
      create_table :traits do |t|
          t.string :name
          t.text :text
      end
  end
end
