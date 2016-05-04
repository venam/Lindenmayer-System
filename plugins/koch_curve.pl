our $CONFIG = {
	x => 100,
	y => 100,
	theta => 0,
	length => 5,
	initial_symbol => 'F',
	grammar => [
		{
			from => 'F',
			to => 'F+F-F-F+F'
		}
	],
	grammar_stabilizer => {
		from => 'f',
		to => 'F'
	},
	dispatch_table => [
		{
			char => 'F',
			foo => \&char_f
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


sub char_f { #draw forward
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += $r * cos($theta);
	printf "y2='%.0f' ", $y += $r * sin($theta);
	print "style='stroke:rgb(30, 30, 30);stroke-width:3'/>\n";
}


sub char_plus {
	$theta += 180*halfpi/180; 
}


sub char_minus {
	$theta -= 180*halfpi/180; 
}
