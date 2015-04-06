package EyeTyrant::App;

use strict;
use warnings;

use JSON;

use Dancer2;
use Data::Dumper;
use Dancer2::Template::TemplateToolkit;
use lib "..";
use EyeTyrant::DataObjects::Character::Manager;
use EyeTyrant::DataObjects::Monster::Manager;

our $VERSION = '0.1';

get '/' => sub {
    my $characters = EyeTyrant::DataObjects::Character::Manager->get_objects;

    warn:Dumper(request->params);

    template 'index', {
        'people'     => $characters,
    };
};

get '/pictures/' => sub {
    template 'pictures';
};

get '/encounter/' => sub {
    template 'encounter';
};

get '/get-monster/' => sub {
    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            name => { like => ['%'.params->{search}.'%']}
        ],
        sort_by => 'name ASC',
    );

    my $monster_list;
    foreach my $mon (@$monsters) {
        print Dumper($mon->name);
    }

     my $json = encode_json $monsters;
     print Dumper($json);

};

true;
