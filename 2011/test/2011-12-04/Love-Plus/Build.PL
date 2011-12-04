use strict;
use warnings;
use inc::MyBuilder;

my $build = inc::MyBuilder->new(
    license              => 'perl',
    dynamic_config       => 0,

    build_requires       => {
        'Test::More' => '0.98',
        'Test::Requires' => 0,
    },
    configure_requires   => { 'Module::Build' => '0.38' },
    requires             => {
        # 'Exporter'                      => '0',
        'parent'                        => '0',
        # 'Plack'                         => '0.9949',
    },

    no_index    => { 'directory' => [ 'inc' ] },
    name        => 'Love-Plus',
    module_name => 'Love::Plus',

    # script_files => [''],

    test_files => (-d '.git' || $ENV{RELEASE_TESTING}) ? 't/ xt/' : 't/',
    recursive_test_files => 1,
   
    create_readme  => 1,
    create_license => 1,
    create_makefile_pl => 'small',
);
$build->create_build_script();

