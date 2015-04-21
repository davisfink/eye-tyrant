package EyeTyrant::DataObjects::Encounter::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use EyeTyrant::DataObjects::Encounter;

sub object_class { 'EyeTyrant::DataObjects::Encounter' }

__PACKAGE__->make_manager_methods('encounters');

1;

