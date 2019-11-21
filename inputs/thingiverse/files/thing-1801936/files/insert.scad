/* 
Battery spacer, http://www.thingiverse.com/thing:1801936
v0.01   2016oct01, ls (http://www.thingiverse.com/Bushmills)
		initial version
v0.02   2016oct01, ls   added twist, some factoring.
v0.03   2016oct02, ls   fixed fin positions on jacket, made thickness of base with rim customisable
v0.04   2016oct02, ls   fin position calculation compacted and simplified
v0.05   2016oct03, ls   simplified punching intersected parts (dropped "difference()"
*/


// ******************************
// *** customisable variables ***
// ******************************

length = 66;			// [10:200]

// jacket+fins
outer_diameter = 27;		// [11:0.1:32]

// jacket-fins
inner_diameter = 18.6;		// [10:0.1:30]

// keep thin for springiness
wall = 0.8;			// [0.4:0.1:5]

// - resulting bottom rim increases adhesion
spring_diameter = 10;		// [2:0.1:20]

fins = 3;			// [3:12]

// should probably be thicker than wall
fin_width = 1;			// [0.4:0.1:3]

// not sure whether this is useful - it may contribute to an interesting look, though.
twist = 60;

// thickness of rim layer. Shortens battery recess depth.
base = 0.9;			// [0:0.1:2]


// *************************
// *** derived variables ***
// *************************

outer_radius = outer_diameter/2;
inner_radius = inner_diameter/2;
jacket_radius = (inner_radius+outer_radius)/2;
spring_radius = spring_diameter/2;
rim = jacket_radius-spring_radius;
fins_angle = 360/fins;
little = 0+0.01;
$fn = 0+90;


// *****************
// *** factoring ***
// *****************

module ring(radius, wall)  {
	difference()  {
		circle(radius+wall/2);
		circle(radius-wall/2);
	}
}


// ****************
// *** the beef ***
// ****************

linear_extrude(base)
ring(jacket_radius-rim/2, rim);							// first layer: rim, hole for spring
linear_extrude(length, twist=twist)  {
	ring(jacket_radius, wall);						// jacket
	intersection()  {
		ring(jacket_radius, outer_radius-inner_radius);
		for (angle=[little:fins_angle:360], orientation=[0, 1])  {
			rotate([0, 0, angle+orientation*fins_angle/2])
			translate([jacket_radius*(orientation+0.5), 0])
			square([jacket_radius, fin_width], center=true);	// fins
		}
	}
}
