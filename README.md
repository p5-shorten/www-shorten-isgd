# NAME

WWW::Shorten::IsGd - Shorten URLs using [https://is.gd](https://is.gd)

# SYNOPSIS

    use strict;
    use warnings;

    use WWW::Shorten::IsGd;
    # use WWW::Shorten 'IsGd';  # or, this way

    my $short_url = makeashorterlink('http://www.foo.com/some/long/url');
    my $long_url  = makealongerlink($short_url);

# DESCRIPTION

A Perl interface to the web site [https://is.gd/](https://is.gd/).  The service simply maintains
a database of long URLs, each of which has a unique identifier.

# FUNCTIONS

## makeashorterlink

The function `makeashorterlink` will call the [https://is.gd](https://is.gd) web site passing
it your long URL and will return the shorter version.

## makealongerlink

The function `makealongerlink` does the reverse. `makealongerlink`
will accept as an argument either the full URL or just the identifier.

If anything goes wrong, then either function will return `undef`.

# AUTHOR

Mike Doherty <`doherty@cpan.org`>

# CONTRIBUTORS

- Chase Whitener <`capoeirab@cpan.org`>

# LICENSE AND COPYRIGHT

Copyright 2011 by Mike Doherty <`doherty@cpan.org`>.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
