package EyeTyrant::App;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index', {
        'msg' => "Test message",
        'page_title' => "eye tyrant",
    };
};

get '/pictures/' => sub {
    template 'pictures';
};

get '/encounter/' => sub {
    template 'encounter';
};

true;
