package EyeTyrant::DataObjects::Spell::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use EyeTyrant::DataObjects::Spell;

sub object_class { 'EyeTyrant::DataObjects::Spell' }

__PACKAGE__->make_manager_methods('spells');

1;

