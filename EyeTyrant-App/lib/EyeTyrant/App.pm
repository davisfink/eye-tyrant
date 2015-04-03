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
    my $monsters   = EyeTyrant::DataObjects::Monster::Manager->get_objects;
    my $characters = EyeTyrant::DataObjects::Character::Manager->get_objects;
    my $character_array = [
        map {
                {
                    name => $_->name,
                    race => $_->race,
                }
            } @$characters
    ];

    template 'index', {
        'msg'        => "Test message",
        'page_title' => "eye tyrant",
        'people'     => $characters,
        'monsters'   => $monsters,
    };
};

get '/pictures/' => sub {
    template 'pictures';
};

get '/encounter/' => sub {
    template 'encounter';
};

true;
