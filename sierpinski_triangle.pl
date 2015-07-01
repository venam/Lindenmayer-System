our $CONFIG = {
	x => 0,
	y => 600,
	theta => 0,
	length => 5,
	initial_symbol => 'A',
	grammar => [
		{
			from => 'A',
			to => 'b-a-b'
		},
		{
			from => 'B',
			to => 'a+b+a'
		}
	],
	grammar_stabilizer => {
		from => 'ab',
		to => 'AB'
	},
	dispatch_table => [
		{
			char => 'A',
			foo => \&draw_forward
		},
		{
			char => 'B',
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
	$theta += 60*2*halfpi/180; 
}


sub char_minus {
	$theta -= 60*2*halfpi/180;
}
