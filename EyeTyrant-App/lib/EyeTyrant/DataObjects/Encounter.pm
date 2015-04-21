package EyeTyrant::DataObjects::Encounter;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'encounter',

    columns => [
        id          => { type => 'serial', not_null => 1 },
        initiative  => { type => 'integer' },
        damage      => { type => 'integer' },
        create_time => { type => 'timestamp' },
    ],

    primary_key_columns => [ 'id' ],
);

1;

