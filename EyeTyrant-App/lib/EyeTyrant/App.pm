package EyeTyrant::App;

use strict;
use warnings;

use JSON;
use Dancer2;
use Data::Dumper;
use Dancer2::Template::TemplateToolkit;
use lib "..";
use EyeTyrant::DataObjects::Character::Manager;
use EyeTyrant::DataObjects::Monster;
use EyeTyrant::DataObjects::Monster::Manager;
use EyeTyrant::DataObjects::Encounter;
use EyeTyrant::DataObjects::Encounter::Manager;
use EyeTyrant::DataObjects::MonsterEncounterMap;
use EyeTyrant::DataObjects::MonsterEncounterMap::Manager;
use Rose::DB::Object::Helpers qw( as_tree as_json );

our $VERSION = '0.1';

get '/' => sub {
    my $characters = EyeTyrant::DataObjects::Character::Manager->get_objects(
        query => [
            is_active => 1,
        ],
    );
    my $encounter = EyeTyrant::DataObjects::Encounter::Manager->get_objects(
        sort_by => 'id DESC',
        limit   => 1,
    )->[0];
    my $monster_participants = EyeTyrant::DataObjects::MonsterEncounterMap::Manager->get_objects(
        query => [
            encounter_id => $encounter->id,
        ],
        require_objects => [qw(monster)],
    );

    template 'index', {
        'people'    => $characters,
        'monsters'  => $monster_participants,
    };
};

get '/search-monster/' => sub {
    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            name => { like => ['%'.params->{search}.'%'] }
        ],
        sort_by => 'name ASC',
    );

    template 'monster', {
        'monsters' => $monsters,
    };

};

get '/autocomplete-monster/' => sub {
    content_type 'application/json';

    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            name => { like => ['%'.params->{term}.'%']}
        ],
        sort_by => 'name ASC',
    );

    my $monster_map = [ map { {label => $_->name, value => $_->id } } @$monsters ];
    return to_json ($monster_map);
};

get '/get-monster/' => sub {
    my $monsters = EyeTyrant::DataObjects::Monster::Manager->get_objects (
        query => [
            id => params->{id},
        ],
        sort_by => 'name ASC',
        require_objects => [qw(experience)],
    );

    template 'monster', {
        'monsters' => $monsters,
    };
};

post '/add-monster/' => sub {
    my $encounter = EyeTyrant::DataObjects::Encounter::Manager->get_objects(
        sort_by => 'id DESC',
        limit   => 1,
    )->[0];

    my $new_encounter_map = EyeTyrant::DataObjects::MonsterEncounterMap->new(
        encounter_id => $encounter->id,
        monster_id   => params->{id},
        damage       => 0,
        initiative   => 1,
        is_active    => 1,
    );

    $new_encounter_map->save();

    redirect '/';
};

get '/new-encounter/' => sub {
    my $encounter = EyeTyrant::DataObjects::Encounter->new()->save();
    my $characters = EyeTyrant::DataObjects::Character::Manager->get_objects(
        query => [
            is_active => 1,
        ],
    );

    #I think this might be pointless, as every active character
    #is in every encounter. Updating their encounter_id serves
    #no purpose..
    while (each @$characters) {
        $characters->[$_]->encounter_id($encounter->id);
        $characters->[$_]->save();
    };


    redirect '/';
};

true;
