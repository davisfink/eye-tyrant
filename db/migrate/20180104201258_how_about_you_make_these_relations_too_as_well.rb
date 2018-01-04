class HowAboutYouMakeTheseRelationsTooAsWell < ActiveRecord::Migration[5.1]
  def change
        remove_reference :monster_types, :traits
        remove_reference :monster_types, :actions
        remove_reference :monster_types, :legendary
        add_reference :traits, :monster_types
        add_reference :actions, :monster_types
        add_reference :legendary, :monster_types
  end
end
