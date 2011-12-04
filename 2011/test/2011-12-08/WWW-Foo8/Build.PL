use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WWW::Foo8',
    license             => 'perl',
    dist_author         => 'Dai Okabayashi <bayashi@cpan.org>',
    dist_version_from   => 'lib/WWW/Foo8.pm',
    build_requires      => {
        'Test::More' => 0.88,
    },
    requires => {
        'Carp' => 0,
    },
    add_to_cleanup      => [ 'WWW-Foo8-*' ],
);

$builder->create_build_script();
