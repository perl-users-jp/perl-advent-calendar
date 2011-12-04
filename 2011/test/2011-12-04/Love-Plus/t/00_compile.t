use strict;
use Test::More tests => 1;

BEGIN { use_ok 'Love::Plus' }

diag "\@INC:\n" . join("\n", @INC);
diag $INC{'Acme/FizzBuzz.pm'};

