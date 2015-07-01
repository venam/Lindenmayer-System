use strict;
use warnings;
use Data::Dumper;

use constant halfpi => atan2(1, 0);
use constant twenty_five => (25/180)*halfpi;


our $CONFIG;
my $fractal = shift @ARGV;
exit if (!$fractal);
require $fractal;


my $iteration_number = shift @ARGV;
my $tr = eval "sub { tr/\Q$CONFIG->{grammar_stabilizer}->{from}\E/\Q$CONFIG->{grammar_stabilizer}->{to}\E/ }" or die $@;

# Computing the fractal with a L-System
my $fractal_string = $CONFIG->{initial_symbol};
for (1 .. $iteration_number) {
	for my $substitution (@{$CONFIG->{grammar}}) {
		$fractal_string =~ s/$substitution->{from}/$substitution->{to}/g;
	}
	$_ = $fractal_string;
	$tr->();
	$fractal_string = $_;
}


our ($x, $y) = ($CONFIG->{x}, $CONFIG->{y});
our $theta = $CONFIG->{theta};
our $r = $CONFIG->{length};

print "<?xml version='1.0' encoding='utf-8' standalone='no'?>
<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 
'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>
	<svg width='60%' height='60%' version='1.1'
xmlns='http://www.w3.org/2000/svg'>\n";
for (split //, $fractal_string) {
	for my $dispatch (@{$CONFIG->{dispatch_table}}) {
		if (/$dispatch->{char}/) {
			$dispatch->{foo}->();
		}
	}
}
print "</svg>";
