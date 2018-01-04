class RemoveMonterTypeColumns < ActiveRecord::Migration[5.1]
    def change
        remove_column :monster_types, :legendary, :text
        remove_column :monster_types, :action, :string
    end
end
