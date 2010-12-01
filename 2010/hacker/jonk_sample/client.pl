#! perl
use strict;
use warnings;
use DBI;
use Jonk::Client;

my $url = shift or die '$0 <url>';
my $dbh = DBI->connect('dbi:SQLite:./sample.db','','');
my $client = Jonk::Client->new($dbh);
$client->enqueue('MyFetcher', $url);

