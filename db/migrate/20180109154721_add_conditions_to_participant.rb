class AddConditionsToParticipant < ActiveRecord::Migration[5.1]
  def change
      add_column :participants, :conditions, :text, array:true
  end
end
