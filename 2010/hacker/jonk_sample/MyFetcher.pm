package MyFetcher;
use strict;
use warnings;
use LWP::UserAgent;

sub work {
    my ($class, $job) = @_;
    my $ua = LWP::UserAgent->new;
    my $res = $ua->get($job->{arg});

    print $$;
    if ($res->is_success) {
        print $res->decoded_content;  # or whatever
    } else {
        print $res->status_line;
    }
}

1;
