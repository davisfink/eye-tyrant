package EyeTyrant::DataObjects::Character::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use EyeTyrant::DataObjects::Character;

sub object_class { 'EyeTyrant::DataObjects::Character' }

__PACKAGE__->make_manager_methods('characters');

1;

