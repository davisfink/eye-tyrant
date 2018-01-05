class AddDefaultValue < ActiveRecord::Migration[5.1]
  def change
      change_column_default :encounters, :active, TRUE
      change_column_default :participants, :damage, 0
      change_column_default :participants, :hitpoints, 0
      change_column_default :participants, :initiative, 0
      change_column_default :parties, :active, TRUE
  end
end
