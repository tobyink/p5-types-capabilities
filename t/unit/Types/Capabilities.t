=pod

=encoding utf-8

=head1 PURPOSE

Unit tests for L<Types::Capabilities>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2025 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use Test2::V0 -target => 'Types::Capabilities';
use Test2::Tools::Spec;
use Data::Dumper;

describe "class `$CLASS`" => sub {

	tests 'type Mappable' => sub {
		ok( Types::Capabilities->has_type( q[Mappable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Mappable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ map / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Mappable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Mappable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub map {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[map] );
	};

	tests 'type Greppable' => sub {
		ok( Types::Capabilities->has_type( q[Greppable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Greppable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ grep / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Greppable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Greppable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub grep {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[grep] );
	};

	tests 'type Sortable' => sub {
		ok( Types::Capabilities->has_type( q[Sortable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Sortable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ sort / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Sortable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Sortable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub sort {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[sort] );
	};

	tests 'type Reversible' => sub {
		ok( Types::Capabilities->has_type( q[Reversible] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Reversible] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ reverse / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Reversible];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Reversible;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub reverse {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[reverse] );
	};

	tests 'type Countable' => sub {
		ok( Types::Capabilities->has_type( q[Countable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Countable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ count / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Countable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Countable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub count {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[count] );
	};

	tests 'type Joinable' => sub {
		ok( Types::Capabilities->has_type( q[Joinable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Joinable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ join / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Joinable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Joinable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub join {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[join] );
	};

	tests 'type Eachable' => sub {
		ok( Types::Capabilities->has_type( q[Eachable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Eachable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ each / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::ARRAYREF], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Eachable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Eachable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub each {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[each] );
	};

	tests 'type Enqueueable' => sub {
		ok( Types::Capabilities->has_type( q[Enqueueable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Enqueueable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ enqueue / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::QUEUE], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Enqueueable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Enqueueable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub enqueue {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::QUEUE] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[enqueue] );
	};

	tests 'type Dequeueable' => sub {
		ok( Types::Capabilities->has_type( q[Dequeueable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Dequeueable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ dequeue / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::QUEUE], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Dequeueable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Dequeueable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub dequeue {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::QUEUE] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[dequeue] );
	};

	tests 'type Peekable' => sub {
		ok( Types::Capabilities->has_type( q[Peekable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Peekable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ peek / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::QUEUE], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Peekable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Peekable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub peek {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::QUEUE] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[peek] );
	};

	tests 'type Pushable' => sub {
		ok( Types::Capabilities->has_type( q[Pushable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Pushable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ push / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::STACK], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Pushable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Pushable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub push {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::STACK] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[push] );
	};

	tests 'type Poppable' => sub {
		ok( Types::Capabilities->has_type( q[Poppable] ), 'type exists' );

		my $type = Types::Capabilities->get_type( q[Poppable] );
		isa_ok( $type, q[Types::Capabilities::Constraint] );
		isa_ok( $type, q[Type::Tiny::Duck] );
		is( [ sort @{ $type->methods } ], [ qw/ pop / ], 'requires the correct methods' );
		ok( $type->can_be_inlined, 'type can be inlined' );
		ok( $type->has_coercion, 'type has a coercion' );
		ok( $type->coercion->can_be_inlined, 'coercion can be inlined' );
		is( $type->{autobox}, q[Types::Capabilities::CoercedValue::STACK], 'type has correct autobox package' );

		my $eg_class = q[Local::Example::Poppable];
		$eg_class->can( 'new' ) or eval q{
			package Local::Example::Poppable;
			sub new {
				my $class = shift;
				bless [@_], $class;
			}
			sub pop {
				die 'Unimplemented';
			}
			1;
		};

		ok(  $type->check( $eg_class->new ), 'example object passes type check' );
		ok( !$type->check(          undef ), 'undef fails type check' );
		ok( !$type->check(              0 ), 'zero fails type check' );
		ok( !$type->check(              1 ), 'one fails type check' );
		ok( !$type->check(             [] ), 'arrayref fails type check' );
		ok( !$type->check(             {} ), 'hashref fails type check' );

		ok( $type->coercion->has_coercion_for_value( [] ), 'an arrayref is theoretically coercible' );

		my $coerced = $type->coerce( [] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::STACK] );
		isa_ok( $coerced, q[Types::Capabilities::CoercedValue::ARRAYREF] );
		ok( $type->check( $coerced ), 'coerced value passes type check' );
		can_ok( $coerced, q[pop] );
	};
};

done_testing;
