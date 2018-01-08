class ParticipantActiveColumn < ActiveRecord::Migration[5.1]
  def change
      add_column :participants, :active, :boolean, default: true
  end
end
