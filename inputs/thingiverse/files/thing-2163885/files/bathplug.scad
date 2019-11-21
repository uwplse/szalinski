/* Bathtube plug. */
/* Delta to compensate openscad non-precise mode. */
DELTA=0.01;
$fn = 100;

PLUG_DIAMETER = 38.8; // [20:0.1:50]
HOLE_DEPTH = 12; // [5:1:20]
RIM = 4; // [1:1:20]
BOTTOM_RIM = 2.8; // [1:0.1:5]
SCREW_RADIUS = 2.6; // [1:0.1:5]
SCREW_OFFSET = 2; // [1:0.1:5]
BOTTOM_SMALLER_BY = 1; // [0:1:20]

NHOLES = 4; // [0, 1, 2, 3, 4, 5, 6]

//Non-configurable values.
CAP_ZSCALE= 0.3;
CAP_HEIGHT = (PLUG_DIAMETER + RIM * 2 ) * CAP_ZSCALE;
HANDLE_RADIUS = 3.5;

module down(amount)
{
     translate([0, 0, -amount])
     {
	  children();
     }
}

/* A hole in the plug body for a screw head. */
module screw_hole()
{
     down(DELTA)
     {
	  cylinder(r = SCREW_RADIUS, h = HOLE_DEPTH + DELTA * 2);
     }
}

/* Main plug body. A cylinder with a recess in the bottom,
   with holes for screws if necessary.
 */
module body()
{
     difference()
     {
	  // body
	  cylinder(r1=PLUG_DIAMETER / 2 - BOTTOM_SMALLER_BY,
		   r2=PLUG_DIAMETER / 2,
		   h=HOLE_DEPTH);
	  // recess
	  scale ([1, 1, 0.2]) sphere(r=PLUG_DIAMETER / 2 - BOTTOM_RIM);
	  // screw holes
	  for(i = [0:1:NHOLES])
	  {
	       rotate([0, 0, i * 360 / NHOLES]) translate([PLUG_DIAMETER / 2, 0, -SCREW_OFFSET])
	       {
		    screw_hole();
	       }
	  }
     }
}

module cap()
{
     translate([0, 0, HOLE_DEPTH-DELTA]) scale([1, 1, CAP_ZSCALE]) difference()
     {
	  translate([0, 0, 1]) sphere(r=(PLUG_DIAMETER / 2) + RIM);
	  w = PLUG_DIAMETER + RIM * 2 + DELTA;
	  translate([-w / 2, -w / 2, -w]) cube([w, w, w]);
     }
}

module handle()
{
     rotate([0, 90, 45]) difference()
     {
	  scale([1.2, 1, 0.9]) rotate_extrude(convexity=20) translate([HANDLE_RADIUS * 4, 0, 0]) circle(r=HANDLE_RADIUS);
	  translate([0,-CAP_HEIGHT,-CAP_HEIGHT]) cube([CAP_HEIGHT * 2, CAP_HEIGHT * 2, CAP_HEIGHT * 2]);
     }
}

module plug()
{
     body();
     cap();
     translate([0, 0, CAP_HEIGHT])
     {
	  handle();
     }
}

plug();
