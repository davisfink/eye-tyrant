class AddDefaultPartyLevel < ActiveRecord::Migration[5.1]
  def change
      change_column_default :parties, :level, 1
  end
end
