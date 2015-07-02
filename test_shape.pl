our $CONFIG = {
	x => 550,
	y => 600,
	theta => 0,
	length => 100,
	initial_symbol => 'YXY',
	grammar => [
		{
			from => 'Y',
			to => '[+[p]+[p]+[p]+[p]]'
		},
		{
			from => 'X',
			to => 'f[!fzy]fy%fy%fy!fyfyxy'
		},
		{
			from => 'Z',
			to => '[+fyfy!fy]ffyfy'
		}
	],
	grammar_stabilizer => {
		from => 'xyfpz',
		to => 'XYFPZ'
	},
	dispatch_table => [
		{
			char => 'F',
			foo => \&draw_forward
		},
		{
			char => 'P',
			foo => \&draw_forward_s
		},
		{
			char => '\+',
			foo => \&char_plus
		},
		{
			char => '\%',
			foo => \&char_ninety
		},
		{
			char => '\!',
			foo => \&char_big_angle
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


sub get_color {
	my $choice = rand();
	if ($choice > 0.5) {
		$choice = rand();
		if($choice > 0.5) {
			return 'rgb(110, 146, 175)';
		}
		else {
			return 'rgb(137, 162, 147)';
		}
	}
	else {
		$choice = rand();
		if($choice > 0.5) {
			return 'rgb(47, 76, 50)';
		}
		else {
			return 'rgb(201, 201, 201)';
		}
	}
}


sub draw_forward {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += $r * cos($theta);
	printf "y2='%.0f' ", $y += $r * sin($theta);
	print "style='stroke:".get_color().";stroke-width:2'/>\n";
}


sub draw_forward_s {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += ($r/3) * cos($theta);
	printf "y2='%.0f' ", $y += ($r/3) * sin($theta);
	print "style='stroke:rgb(30, 30, 70);stroke-width:1'/>\n";
}


sub char_big_angle {
	$theta += (45*2*halfpi)/180; 
}


sub char_plus {
	$theta += (30*2*halfpi)/180; 
}


sub char_ninety {
	$theta += (90*2*halfpi)/180; 
}


sub char_minus {
	$theta -= (30*2*halfpi)/180;
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
