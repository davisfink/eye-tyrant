class CreateDatabase < ActiveRecord::Migration[5.1]
  def change
      create_table :encounters do |t|
          t.boolean :active
          t.integer :party_id
          t.integer :active_participant_id
      end
  end
end
