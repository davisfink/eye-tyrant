package EyeTyrant::DataObjects::Experience::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use EyeTyrant::DataObjects::Experience;

sub object_class { 'EyeTyrant::DataObjects::Experience' }

__PACKAGE__->make_manager_methods('experiences');

1;

