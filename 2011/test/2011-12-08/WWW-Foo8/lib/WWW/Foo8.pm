package WWW::Foo8;
use strict;
use warnings;

our $VERSION = '0.01';

use Class::Accessor::Lite (
    rw  => [qw/agent error/],
);

sub new {
    my ($class, %args) = @_;

    $args{agent} = _default_agent() unless $args{agent};
    bless \%args, $class;
}

sub get {
    my ($self, $uri) = @_;

    my $response = $self->agent->get($uri);

    if ($response->is_success) {
        return $response->content;
    }
    else {
        $self->error($response->status_line);
        return;
    }
}

sub _default_agent {
    require Furl; return Furl->new;
}

1;

__END__

=head1 NAME

WWW::Foo8 - sample module


=head1 SYNOPSIS

    use WWW::Foo8;

    my $foo = WWW::Foo8->new;
    my $res = $foo->get('http://example.org');


=head1 DESCRIPTION

WWW::Foo8 is sample module for describing tests with network access


=head1 METHOD

=over

=item new(I<%args>)

constructor

=item get(I<$uri>)

get page

=item agent(I<$agent_obj>)

user-agent object

=item error

get error message

=back

=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
