our $CONFIG = {
	x => 200,
	y => 900,
	theta => 0,
	length => 5,
	initial_symbol => 'X',
	grammar => [
		{
			from => 'X',
			to => 'f-[[x]+x]+f[+fx]-x'
		},
		{
			from => 'F',
			to => 'ff'
		}
	],
	grammar_stabilizer => {
		from => 'xf',
		to => 'XF'
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
		},
		{
			char => '\[',
			foo => \&char_l
		},
		{
			char => '\]',
			foo => \&char_r
		}
	]
};


our @pos_and_angle_stack;


sub char_f {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += $r * cos($theta);
	printf "y2='%.0f' ", $y += $r * sin($theta);
	print "style='stroke:rgb(153, 168, 55);stroke-width:3'/>\n";
}


sub char_plus {
	$theta += twenty_five; 
}


sub char_minus {
	$theta -= twenty_five; 
}


sub char_l {
	push @pos_and_angle_stack, {x=>$x, y=>$y, theta=>$theta};
}


sub char_r {
	my $p_n_a = pop @pos_and_angle_stack;
	$x = $p_n_a->{x};
	$y = $p_n_a->{y};
	$theta = $p_n_a->{theta};

}

1;
