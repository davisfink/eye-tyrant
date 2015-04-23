package EyeTyrant::App;

use strict;
use warnings;

use JSON;
use JSON::XS;

use Dancer2;
use Data::Dumper;
use Dancer2::Template::TemplateToolkit;
use lib "..";
use EyeTyrant::DataObjects::Character::Manager;
use EyeTyrant::DataObjects::Monster::Manager;
use Rose::DB::Object::Helpers qw( as_tree as_json );

our $VERSION = '0.1';

get '/' => sub {
    my $characters = EyeTyrant::DataObjects::Character::Manager->get_objects;

    template 'index', {
        'people' => $characters,
    };
};

get '/pictures/' => sub {
    template 'pictures';
};

get '/encounter/' => sub {
    template 'encounter';
};

get '/search-monster/' => sub {
    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            name => { like => ['%'.params->{search}.'%'] }
        ],
        sort_by => 'name ASC',
    );

    print Dumper($monsters);

    template 'monster', {
        'monsters' => $monsters,
    };

};

get '/autocomplete-monster/' => sub {
    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            name => { like => ['%'.params->{search}.'%']}
        ],
        sort_by => 'name ASC',
    );

    my $monster_map = [ map {as_tree($_)} @$monsters ];

    warn Dumper($monster_map);
    foreach my $mob ($monsters) {
    };

};

get '/get-monster/' => sub {
    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            id => params->{id},
        ],
        sort_by => 'name ASC',
    );

    template 'monster', {
        'monsters' => $monsters,
    };
};

true;
