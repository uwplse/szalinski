/* 
Thread-Spool for use with Singer Professional XL1000 sewing machine
by zeus - zeus@ctdo.de - 2014-12-11
remixed from "Thread Spool" ( http://www.thingiverse.com/thing:28902 )
by Mike Creuzer - Mike@Creuzer.com 20120820

With this spool you can re-spool thread from bigger spools, which have too much 
mass and tend to cut off or break your needle. Unfortunately its not fully automatic, 
because you have to use your fingers to guide the tread while respooling, to make
sure, that the spool is evenly filled, becuase the respooler is originally designed 
to spool the under-thread-spool.
*/ 



// Parameters are in mm

// The radius of the spool (half the diameter)
spool_radius = 5.6; // 17.6 / 2 for the toy I used
// The height of the spool
spool_height = 60.0;

// The top and bottom radius
lip_radius = 8.8; // 21.6 / 2 for the toy I used
// The height of the top and bottom
lip_height = 2.0;

// The radius of the whole in the center
spindle_radius = 3.6; // 7.4/2

$fn=25;

difference()
{
	union() // Make the spool
	{
		cylinder(r=spool_radius, h=spool_height);
		cylinder(r=lip_radius, h=lip_height);
		translate([0,0,lip_height]) cylinder(r1=lip_radius, r2 = spool_radius, h=lip_height);
		translate([0,0,spool_height-lip_height]) cylinder(r=lip_radius, h=lip_height);
		translate([0,0,spool_height-lip_height-lip_height]) cylinder(r2=lip_radius, r1 = spool_radius, h=lip_height);
	}
	cylinder(r=spindle_radius, h=spool_height); // The hole down the middle
}
