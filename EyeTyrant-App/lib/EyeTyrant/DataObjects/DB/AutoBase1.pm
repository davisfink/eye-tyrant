package EyeTyrant::DataObjects::DB::AutoBase1;

use strict;

use base 'Rose::DB';

__PACKAGE__->use_private_registry;

__PACKAGE__->register_db
(
  driver   => 'mysql',
  dsn      => 'dbi:mysql:database=eye_tyrant;host=127.0.0.1',
  password => 'Kadena.1',
  schema   => 'eye_tyrant',
  username => 'root',
);

1;
