use strict;
use warnings;
use Test::More 0.88;

use WWW::Foo8;

can_ok 'WWW::Foo8', qw/new agent error get/;

# new
{
    my $foo = WWW::Foo8->new;
    is ref($foo), 'WWW::Foo8', 'new';
    is ref($foo->agent), 'Furl', 'default agent';
}

# new option
{
    require LWP::UserAgent;
    my $bar = WWW::Foo8->new(
        agent => LWP::UserAgent->new,
    );
    is ref($bar->agent), 'LWP::UserAgent', 'not defalt agent';
}

# set ua after new
{
    my $baz = WWW::Foo8->new;
    $baz->agent(LWP::UserAgent->new);
    is ref($baz->agent), 'LWP::UserAgent', 'change agent';
}

done_testing;
