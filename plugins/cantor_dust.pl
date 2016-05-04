=head1
variables : A B
constants : none
start  : A {starting character string}
rules  : (A -> ABA), (B -> BBB)
=cut

our $CONFIG = {
	x => 200,
	y => 200,
	theta => 0,
	length => 5,
	initial_symbol => 'A',
	grammar => [
		{
			from => 'A',
			to => 'aba'
		},
		{
			from => 'B',
			to => 'bbb'
		}
	],
	grammar_stabilizer => {
		from => 'ab',
		to => 'AB'
	},
	dispatch_table => [
		{
			char => 'A',
			foo => \&char_a
		},
		{
			char => 'B',
			foo => \&char_b
		}
	]
};


sub char_a { #draw forward
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += $r * cos($theta);
	printf "y2='%.0f' ", $y += $r * sin($theta);
	print "style='stroke:rgb(30, 30, 30);stroke-width:3'/>\n";
}

sub char_b {
	$x += $CONFIG->{length};
}
