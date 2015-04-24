package EyeTyrant::DataObjects::Encounter;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'encounter',

    columns => [
        id => { type => 'serial', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    relationships => [
        monsters => {
            map_class => 'EyeTyrant::DataObjects::MonsterEncounterMap',
            map_from  => 'encounter',
            map_to    => 'monster',
            type      => 'many to many',
        },
    ],
);

1;

