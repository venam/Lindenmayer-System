our $CONFIG = {
	x => 150,
	y => 290,
	theta => 0,
	length => 10,
	initial_symbol => 'X',
	grammar => [
		{
			from => 'X',
			to => '[Y][Z]'
		},
		{
			from => 'Y',
			to => '
{
[[+++++++++ddd]+++dd[++++++ddd]]
+++ff
[++++dddd]
f
[--dd--d--dd---d---dd----dd]
d
[++f++d++dd++++dd++++dd+++++ddd]
--
ddd
[----f]
-f[++ddd]++f[--ddd]
[++f+d++d++dd++dd+++d++++dd+++dd++++dd++++dd]
--f[+ddd][------ddd]---f
[----f---d---dd-----dd]
--f
[++++ddd]
f
[ffffffffffffff---x]
}
-----ff++++dd++dd+++dd+++ddd++++dd++++ddd++++++dd
'
		},
		{
			from => 'Z',
			to => '
{[------------ddd++++ddd++++d++++d+++++d]
-----ff
[++++++d+d++++d++++++++dd]
-f
[++++++dd---d-----d-----d---d-----d]
f+dd+dd+f++++f+++++f---dd---f--dd
[-----ddd-d-d-d]
-f
f
[----f----dd[f]-d---d----ddd--d-----dd]
-f
[++++++dd+++dd++f++dd+++++dd]
++ddd----
dd---dd----dd
f
}
'
		}
	],
	grammar_stabilizer => {
		from => 'dxyzf',
		to => 'DXYZF'
	},
	dispatch_table => [
		{
			char => 'F',
			foo => \&char_f
		},
		{
			char => 'D',
			foo => \&char_d
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
			char => '\{',
			foo => \&angle_push
		},
		{
			char => '\}',
			foo => \&angle_pop
		},
		{
			char => '\]',
			foo => \&char_r
		}
	]
};


our @pos_and_angle_stack;
our @angle_stacks;


sub char_f {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += $r * cos($theta);
	printf "y2='%.0f' ", $y += $r * sin($theta);
	print "style='stroke:rgb(15, 15, 15);stroke-width:3'/>\n";
}


sub char_d {
	printf "<line x1='%.0f' y1='%.0f' ", $x, $y;
	printf "x2='%.0f' ", $x += ($r/4) * cos($theta);
	printf "y2='%.0f' ", $y += ($r/4) * sin($theta);
	print "style='stroke:rgb(15, 15, 15);stroke-width:3'/>\n";
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


sub angle_push {
	push @angle_stacks,$theta;
}


sub angle_pop {
	$theta = pop @angle_stacks;
}


1;
