class ParticipantConditions < ActiveRecord::Migration[5.1]
  def change
      remove_column :participants, :conditions
      create_join_table :participants, :conditions
  end
end
