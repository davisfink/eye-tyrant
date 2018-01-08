class TraitAlterTableAttack < ActiveRecord::Migration[5.1]
  def change
      change_column :traits, :attack, :text
  end
end
