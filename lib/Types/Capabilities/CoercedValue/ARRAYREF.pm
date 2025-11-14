use 5.010001;
use strict;
use warnings;

package Types::Capabilities::CoercedValue::ARRAYREF;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.001000';

use Types::TypeTiny ();

sub new {
	my $class = shift;
	my $new = bless [ @{+shift} ], $class;
	&Internals::SvREADONLY($new, 1);
	return $new;
}

sub _coercions {
	my $k = B::perlstring( shift );
	return ( Types::TypeTiny::ArrayLike(), qq{$k->new(\$_)} );
}

1;

__END__
