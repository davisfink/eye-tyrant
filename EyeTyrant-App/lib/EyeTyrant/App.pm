package EyeTyrant::App;

use strict;
use warnings;

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
        'msg'        => "Test message",
        'page_title' => "eye tyrant",
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
    my $search_term  = request->params->{monster};
    my $monsters     = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            name => { like => ['%'.$search_term.'%']}
        ],
        sort_by => 'name ASC',
    );

    template 'monster', {
        'monsters'   => $monsters,
        'query'      => $search_term,
    };
};

true;
