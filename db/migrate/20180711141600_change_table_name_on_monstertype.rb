class ChangeTableNameOnMonstertype < ActiveRecord::Migration[5.1]
  def change
      rename_column :monster_types, :save, :saving_throw
  end
end
