class LegendaryTextArray < ActiveRecord::Migration[5.1]
  def change
      remove_column :legendaries, :text
      add_column :legendaries, :text, :text, array:true
  end
end
