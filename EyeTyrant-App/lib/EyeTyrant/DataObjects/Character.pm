package EyeTyrant::DataObjects::Character;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'character',

    columns => [
        id         => { type => 'serial', not_null => 1 },
        name       => { type => 'varchar', length => 100 },
        race       => { type => 'varchar', length => 50 },
        perception => { type => 'integer' },
    ],

    primary_key_columns => [ 'id' ],
);

1;

