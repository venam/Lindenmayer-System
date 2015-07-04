#A Generic Lindermayer System Parser


A simplied way to write Lindenmayer systems


##Usage##


```bash
perl lindermayer.pl [fractal_script.pl] [nb of iterations] > output.svg
convert output.svg [-rotate '180'] output.jpg
```


The only part that needs to be written is the `fractal_script.pl`.  
It should contain a config of the following form:

```perl
our $CONFIG = {
	x => 1, #initial x posiion
	y => 1, #initial y position
	theta => 0, #initial drawing angle
	length => 1, #length of the drawing
	initial_symbol => 'F', #starting symbol of the grammar
	grammar => [ #the transition grammar - what each symbols will become
		{
			from => 'F',
			to => 'F+F-F-F+F'
		}
	],
	grammar_stabilizer => { #used to stabilize the grammar
							#if you don't want 2 transition happening at the same time
		from => 'f',
		to => 'F'
	},
	dispatch_table => [ #dispatch table - what each character will be executed as
						#it contains pointer to subroutines
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
```


##Example Outputs##

![test shape 9 iter](https://raw.githubusercontent.com/venam/Lindenmayer-System/master/test_shape.jpg)
![test shape 15 iter](https://raw.githubusercontent.com/venam/Lindenmayer-System/master/test_shape_15.jpg)
![test shape 35 iter](https://raw.githubusercontent.com/venam/Lindenmayer-System/master/test_shape_35.jpg)
