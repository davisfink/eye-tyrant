package EyeTyrant::App;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/pictures/' => sub {
    template 'pictures';
};

get '/encounter/' => sub {
    template 'encounter';
};

true;
