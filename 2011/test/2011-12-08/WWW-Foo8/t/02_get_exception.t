use strict;
use warnings;
use Test::More 0.88;
use Test::Exception;

use WWW::Foo8;

# exception test
{
    my $foo = WWW::Foo8->new;
    throws_ok { $foo->get(undef) } qr/^Missing host name/,    'undef';
    throws_ok { $foo->get('') } qr/^Passed malformed URL/,    'blank';
    throws_ok { $foo->get(0) } qr/Passed malformed URL/,      'zero';
    throws_ok { $foo->get('hoge') } qr/Passed malformed URL/, 'not URL';
}

done_testing;