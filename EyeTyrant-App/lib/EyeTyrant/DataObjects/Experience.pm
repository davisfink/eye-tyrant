package EyeTyrant::DataObjects::Experience;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'experience',

    columns => [
        id  => { type => 'serial', not_null => 1 },
        cr  => { type => 'varchar', length => 11, not_null => 1 },
        exp => { type => 'integer' },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'cr' ],

    relationships => [
        monsters => {
            class      => 'EyeTyrant::DataObjects::Monster',
            column_map => { cr => 'cr' },
            type       => 'one to many',
        },
    ],
);

1;

