package EyeTyrant::DataObjects::Spell;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'spell',

    columns => [
        id         => { type => 'serial', not_null => 1 },
        time       => { type => 'varchar', length => 255 },
        components => { type => 'text', length => 65535 },
        duration   => { type => 'varchar', length => 255 },
        classes    => { type => 'varchar', length => 255 },
        level      => { type => 'varchar', length => 2 },
        name       => { type => 'varchar', length => 255 },
        range      => { type => 'varchar', length => 255 },
        school     => { type => 'varchar', length => 100 },
        ritual     => { type => 'varchar', length => 100 },
        text       => { type => 'text', length => 65535 },
    ],

    primary_key_columns => [ 'id' ],
);

1;

