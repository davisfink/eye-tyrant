package EyeTyrant::DataObjects::DB::Object::AutoBase2;

use base 'Rose::DB::Object';

use EyeTyrant::DataObjects::DB::AutoBase1;

sub init_db { EyeTyrant::DataObjects::DB::AutoBase1->new }

1;
