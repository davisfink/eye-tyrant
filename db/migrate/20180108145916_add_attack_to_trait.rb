class AddAttackToTrait < ActiveRecord::Migration[5.1]
  def change
      add_column :traits, :attack, :text, array: true
  end
end
