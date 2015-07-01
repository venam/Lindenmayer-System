our $CONFIG = {
	x => 400,
	y => 900,
	theta => 0,
	length => 5,
	initial_symbol => 'FX',
	grammar => [
		{
			from => 'X',
			to => 'x+yF+'
		},
		{
			from => 'Y',
			to => '-Fx-y'
		}
	],
	grammar_stabilizer => {
		from => 'xy',
		to => 'XY'
	},
	dispatch_table => [
		{
			char => 'F',
			foo => \&draw_forward
		},
		{
			char => '\+',
			foo => \&char_plus
		},
		{
			char => '\-',
			foo => \&char_minus
		}
	]
};


sub draw_forward {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += $r * cos($theta);
	printf "y2='%.0f' ", $y += $r * sin($theta);
	print "style='stroke:rgb(30, 30, 70);stroke-width:3'/>\n";
}


sub char_plus {
	$theta += (90*2*halfpi)/180; 
}


sub char_minus {
	$theta -= (90*2*halfpi)/180;
}
