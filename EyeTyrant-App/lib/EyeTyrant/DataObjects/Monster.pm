package EyeTyrant::DataObjects::Monster;

use strict;

use base qw(EyeTyrant::DataObjects::DB::Object::AutoBase2);

__PACKAGE__->meta->setup(
    schema => 'eye_tyrant',
    table  => 'monster',

    columns => [
        ac              => { type => 'varchar', length => 256 },
        action          => { type => 'text', length => 65535 },
        alignment       => { type => 'varchar', length => 50 },
        cha             => { type => 'integer' },
        con             => { type => 'integer' },
        conditionImmune => { type => 'varchar', length => 256 },
        cr              => { type => 'varchar', length => 5 },
        dex             => { type => 'integer' },
        hp              => { type => 'varchar', length => 20 },
        id              => { type => 'serial', not_null => 1 },
        immune          => { type => 'varchar', length => 256 },
        int             => { type => 'integer' },
        languages       => { type => 'varchar', length => 256 },
        name            => { type => 'varchar', length => 100 },
        passive         => { type => 'varchar', length => 256 },
        resist          => { type => 'varchar', length => 256 },
        saves           => { type => 'varchar', length => 256 },
        senses          => { type => 'varchar', length => 256 },
        size            => { type => 'varchar', length => 100 },
        skill           => { type => 'varchar', default => '', length => 256 },
        speed           => { type => 'varchar', length => 256 },
        str             => { type => 'integer' },
        trait           => { type => 'text', length => 65535 },
        type            => { type => 'varchar', length => 256 },
        vulnerable      => { type => 'varchar', length => 256 },
        wis             => { type => 'integer' },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        experience => {
            class       => 'EyeTyrant::DataObjects::Experience',
            key_columns => { cr => 'cr' },
        },
    ],
);

1;

