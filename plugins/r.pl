our $CONFIG = {
	x => 130,
	y => 130,
	theta => 0,
	length => 10,
	initial_symbol => '(R)_u__(E)_u__(I)_u__(N)____u_(E)',
	grammar => [
		{
			from => 'R',
			to => '{TzTTzTTzTTTT%TzTT%TzT+TzTT--TTzTTzT}'
		},
		{
			from => 'E',
			to => '{[TTzTT%zTT%zTT%TTz]%TzTT}'
		},
		{
			from => 'I',
			to => '[TzTTzT]'
		},
		{
			from => 'N',
			to => '[TTzTT+++++TTzTTT-----TTzTTzT]'
		},
		{
			from => '_',
			to => '{%W}'
		},
		{
			from => 'U',
			to => '[f+f]'
		},
		{
			from => 'Y',
			to => '[--f[p]+[p]+[p]+[p]]'
		},
		{
			from => 'X',
			to => 'f[!fzy--fz]fy%fy%fy!fyfyxy'
		},
		{
			from => 'Z',
			to => '[(@[-yfyfy!fyffy-z])]yfu[+f]fy'
		}
	],
	grammar_stabilizer => {
		from => 'xyfpzu',
		to => 'XYFPZU'
	},
	dispatch_table => [
		{
			char => 'F',
			foo => \&draw_forward
		},
		{
			char => 'T',
			foo => \&draw_forward_bold
		},
		{
			char => 'P',
			foo => \&draw_forward_s
		},
		{
			char => 'U',
			foo => \&draw_flower
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
		},
		{
			char => '\@',
			foo => \&thick_reduce
		},
		{
			char => '\(',
			foo => \&thick_push
		},
		{
			char => '\)',
			foo => \&thick_pop
		},
		{
			char => '\{',
			foo => \&angle_push
		},
		{
			char => '\}',
			foo => \&angle_pop
		},
		{
			char => 'W',
			foo => \&go_forward
		}
	]
};


our @pos_and_angle_stack;
our @angle_stacks;
our @thickness_stack;
my $citron = "rgb(153, 168, 55)";
my $orchid = "rgb(168, 55, 144)";
my $branch_col = "rgb(47, 76, 50)";
my $thickness = 4;

sub go_forward {
	$y += 40;
}

sub get_color {
	my $choice = rand();
	return $citron;
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
	print "style='stroke:".get_color().";stroke-width:$thickness'/>\n";
}


sub draw_forward_bold {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += ($r+10) * cos($theta);
	printf "y2='%.0f' ", $y += ($r+4) * sin($theta);
	print "style='stroke:$branch_col;stroke-width:20'/>\n";
}


sub draw_forward_s {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += ($r/3) * cos($theta);
	printf "y2='%.0f' ", $y += ($r/3) * sin($theta);
	print "style='stroke:rgb(30, 30, 70);stroke-width:1'/>\n";
}

sub draw_flower {
	printf "<circle cx='%.0f' cy='%.0f' r='4' ", $x+3, $y+3;
	print "style='fill:$orchid;stroke-width:3'/>\n";
	printf "<circle cx='%.0f' cy='%.0f' r='4' ", $x-3, $y-3;
	print "style='fill:$orchid;stroke-width:3'/>\n";
	printf "<circle cx='%.0f' cy='%.0f' r='4' ", $x+3, $y-3;
	print "style='fill:$orchid;stroke-width:3'/>\n";
	printf "<circle cx='%.0f' cy='%.0f' r='4' ", $x-3, $y+3;
	print "style='fill:$orchid;stroke-width:3'/>\n";
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

sub angle_push {
	push @angle_stacks,$theta;
}

sub angle_pop {
	$theta = pop @angle_stacks;
}

sub thick_reduce {
	$thickness -= $thickness/9;
}

sub thick_push {
	push @thickness_stack, $thickness;
}

sub thick_pop {
	$thickness = pop @thickness_stack, $thickness;
}

1;
