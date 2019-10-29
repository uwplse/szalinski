use <write/Write.scad>;

//How many tubes?
tubes=8; // [1:30]
//Starting tube number?
numstart=1;
//Label the tubes with numbers?
numbers="Yes";  // [Yes,No]

/* [Hidden] */
$fn=50;

width=tubes*16; //increments of 16

difference()
	{
		cube ([width+1,115,13]);

	for (x=[0:width/16+1])
		{
		translate([x*16-7.5,5,8]) rotate([-90,0,0]) cylinder (r=7.1,h=120);
		translate([x*16-7.5,15,-1])cylinder (r=2.5,h=4);
		translate([x*16-7.5,65,-1])cylinder (r=2.5,h=4);
		translate([x*16-7.5,55,-1])cylinder (r=2.5,h=4);
		translate([x*16-7.5,105,-1])cylinder (r=2.5,h=4);
		translate([x*16-10,15,-1])cube([5,40,4]);
		translate([x*16-10,65,-1])cube([5,40,4]);
		}
	for (y=[0:9])
		{
		translate([-1,y*10+14,12]) cube([width+5,1,2]);
		}
	}
difference() {
	cube ([width+1,5,25]);
	if (numbers=="Yes")
		{
		for (c=[1:tubes])
			{
			translate([c*16-10,4,23]) rotate([90,180,180]) write(str(numstart+c-1),h=8, t=4);
			}
		}
	}