package EyeTyrant::DataObjects::MonsterEncounterMap;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'monster_encounter_map',

    columns => [
        damage       => { type => 'integer' },
        encounter_id => { type => 'integer', not_null => 1 },
        hitpoints    => { type => 'integer' },
        id           => { type => 'serial', not_null => 1 },
        initiative   => { type => 'integer' },
        is_active    => { type => 'integer', default => 1, not_null => 1 },
        monster_id   => { type => 'integer', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        encounter => {
            class       => 'EyeTyrant::DataObjects::Encounter',
            key_columns => { encounter_id => 'id' },
        },

        monster => {
            class       => 'EyeTyrant::DataObjects::Monster',
            key_columns => { monster_id => 'id' },
        },
    ],
);

1;

