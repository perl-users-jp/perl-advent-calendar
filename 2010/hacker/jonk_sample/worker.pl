use strict;
use warnings;
use Parallel::Prefork;
use DBI;
use Jonk::Worker;
use MyFetcher;

my $pm = Parallel::Prefork->new({
    max_workers       => 10,
    trap_signals      => {
        TERM => 'TERM',
        HUP  => 'TERM',
    },
});

while ($pm->signal_received ne 'TERM') {
    $pm->start and next;

    my $dbh = DBI->connect('dbi:SQLite:./sample.db','','');
    my $jonk = Jonk::Worker->new($dbh => {functions => [qw/MyFetcher/]});

    while (1) {
        if (my $job = $jonk->dequeue) {
            MyFetcher->work($job);
        } else {
            sleep(3); # wait for 3 sec.
        }
    }

    $pm->finish;
}

$pm->wait_all_children();
