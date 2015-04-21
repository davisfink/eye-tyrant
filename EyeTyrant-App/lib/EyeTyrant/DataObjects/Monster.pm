package EyeTyrant::DataObjects::Monster;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'monster',

    columns => [
        id              => { type => 'serial', not_null => 1 },
        name            => { type => 'varchar', length => 100 },
        size            => { type => 'varchar', length => 100 },
        type            => { type => 'varchar', length => 256 },
        alignment       => { type => 'varchar', length => 50 },
        ac              => { type => 'varchar', length => 256 },
        hp              => { type => 'varchar', length => 20 },
        speed           => { type => 'varchar', length => 256 },
        str             => { type => 'integer' },
        dex             => { type => 'integer' },
        con             => { type => 'integer' },
        int             => { type => 'integer' },
        wis             => { type => 'integer' },
        cha             => { type => 'integer' },
        saves           => { type => 'varchar', length => 256 },
        skill           => { type => 'varchar', default => '', length => 256 },
        vulnerable      => { type => 'varchar', length => 256 },
        resist          => { type => 'varchar', length => 256 },
        immune          => { type => 'varchar', length => 256 },
        conditionImmune => { type => 'varchar', length => 256 },
        senses          => { type => 'varchar', length => 256 },
        passive         => { type => 'varchar', length => 256 },
        languages       => { type => 'varchar', length => 256 },
        cr              => { type => 'varchar', length => 5 },
        trait           => { type => 'text', length => 65535 },
        action          => { type => 'text', length => 65535 },
    ],

    primary_key_columns => [ 'id' ],
);

1;

