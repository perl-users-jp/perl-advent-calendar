use strict;
use warnings;
use LWP::Online ':skip_all'; # skip all test unless online
use Test::More 0.88;

use WWW::Foo8;

##############################
# many ways to test for 'get'
##############################

# real access
{
    my $res = WWW::Foo8->new->get('http://example.org/');
    like $res, qr{<title>IANA[^<]+</title>}, 'example.org';
}

# real access, however comment out
{
    my $res = WWW::Foo8->new->get('http://example.org/');
    #like $res, qr{<title>IANA[^<]+</title>}, 'example.org';
}

# need env
if ($ENV{WWW_FOO8_DO_TEST}) {
    my $res = WWW::Foo8->new->get('http://example.org/');
    like $res, qr{<title>IANA[^<]+</title>}, 'example.org';
}

# skip it!
SKIP: {
    skip 'no more DDoS', 1 unless $ENV{WWW_FOO8_DO_TEST};
    my $res = WWW::Foo8->new->get('http://example.org/');
    like $res, qr{<title>IANA[^<]+</title>}, 'example.org';
}

# use fake HTTPD
{
    use Test::Fake::HTTPD;
    {
        my $fake_res = HTTP::Response->new(
            200, 'ok', ['Content-Type' => 'text/html'],
            '<html><head><title>IANA example.org</title></head><body></body></html>'
        );
        my $httpd = run_http_server { $fake_res };
        my $res = WWW::Foo8->new->get($httpd->endpoint);
        like $res, qr{<title>IANA[^<]+</title>}, 'fake example.org';
    }

    {
        my $httpd = run_http_server { HTTP::Response->new(404) };
        my $foo = WWW::Foo8->new;
        my $res = $foo->get($httpd->endpoint);
        is $res, undef, 'fake 404';
        is $foo->error, '404 Not Found', 'error';
    }

    {
        my $httpd = run_http_server { HTTP::Response->new(500) };
        my $foo = WWW::Foo8->new;
        my $res = $foo->get($httpd->endpoint);
        is $res, undef, 'fake 500';
        is $foo->error, '500 Internal Server Error', 'error';
    }
}




done_testing;