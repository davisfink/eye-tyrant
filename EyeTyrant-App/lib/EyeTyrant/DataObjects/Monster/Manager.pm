package EyeTyrant::DataObjects::Monster::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use EyeTyrant::DataObjects::Monster;

sub object_class { 'EyeTyrant::DataObjects::Monster' }

__PACKAGE__->make_manager_methods('monsters');

1;

