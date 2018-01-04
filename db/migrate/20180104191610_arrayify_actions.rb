class ArrayifyActions < ActiveRecord::Migration[5.1]
  def change
      remove_column :actions, :text
      remove_column :legendary, :text
      remove_column :traits, :text

      add_column :actions, :text, :text, array: true
      add_column :legendary, :text, :text, array: true
      add_column :traits, :text, :text, array: true
  end
end
