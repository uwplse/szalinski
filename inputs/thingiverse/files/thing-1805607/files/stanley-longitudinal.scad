width = 51;	// [ 30:120 ]
length = 131;	// [ 80:200 ] 
height = 30;	// [  5:60 ]
foot = 8;	// [ 0:120 ]
wall = 1;	// [ 0.3:0.1:12]
floor = 0.9;	// [ 0:0.1:12]

translate([0, 0, floor/2])
cube([length, foot, floor], center=true);		// bottom bar
linear_extrude(height)
difference()  {
	square([length, width], center=true);
	for (i=[-1, 1])
	translate([0, i*(width+wall)/2])
	square([length-2*wall, width], center=true);
}
