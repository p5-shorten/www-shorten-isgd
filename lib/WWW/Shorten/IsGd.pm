use strict;
use warnings;
use 5.006;

package WWW::Shorten::IsGd;
# ABSTRACT: Shorten (or lengthen) URLs with http://is.gd

=head1 SYNOPSIS

	use WWW::Shorten::IsGd;

	my $url = q{http://averylong.link/wow?thats=really&really=long};
	my $short_url = makeashorterlink($url);
	my $long_url  = makealongerlink($short_url); # eq $url

=head1 DESCRIPTION

A Perl interface to the web site L<http://is.gd>. is.gd simply maintains
a database of long URLs, each of which has a unique identifier.

=cut

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
use Carp;
use URI;

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the is.gd web site passing
it your long URL and will return the shortened link.

=cut

sub makeashorterlink {
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $response = $ua->post('http://is.gd/create.php', [
        url => $url,
        source => 'PerlAPI-' . (defined __PACKAGE__->VERSION ? __PACKAGE__->VERSION : 'dev'),
        format => 'simple',
	]);
    return unless $response->is_success;
    my $shorturl = $response->{_content};
    return if $shorturl =~ m/Error/;
    if ($response->content =~ m{(\Qhttp://is.gd/\E[\w_]+)}) {
		return $1;
    }
    return;
}

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full TinyURL URL or just the
TinyURL identifier.

If anything goes wrong, then either function will return C<undef>.

=cut

sub makealongerlink {
    my $url = shift or croak 'No is.gd key/URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

	$url = "http://is.gd/$url" unless $url =~ m{^https?://}i;
    my $response = $ua->get($url);

    return unless $response->is_redirect;
    return $response->header('Location');
}

1;

__END__
