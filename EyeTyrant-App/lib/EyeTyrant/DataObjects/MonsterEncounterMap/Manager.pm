package EyeTyrant::DataObjects::MonsterEncounterMap::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use EyeTyrant::DataObjects::MonsterEncounterMap;

sub object_class { 'EyeTyrant::DataObjects::MonsterEncounterMap' }

__PACKAGE__->make_manager_methods('monster_encounter_maps');

1;

