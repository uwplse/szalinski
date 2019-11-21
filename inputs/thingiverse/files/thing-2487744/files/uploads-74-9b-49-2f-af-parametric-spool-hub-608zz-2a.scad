//-- Parametric Spool Hub with 608zz bearing
//-- remixed from thing #545954 by mateddy (James Lee)
//-- redesigned from thing #27139 by QuantumConcepts (Josh McCullough)
//-- and also based on a brilliant design by Sylvain Rochette (labidus),
//-- Thingiverse thing #596838.
//-- AndrewBCN - Barcelona, Spain - December 2014
//-- GPLV3


// Parameters

// Spool Hole Diameter
spool_hole_diam = 53.5; // [40.0:60.0]
// Internal Spool Thickness
spool_wall_thickness=9; // [5.0:12.0]
// Add a bevel to let the bearing snap in easier
bearing_snap_in_helper=1; //[0:no, 1:yes]

/* [Hidden] */
//-- the rest are not adjustable
bearing_snap_in_helper_height=2;
bearing_snap_in_helper_width=1;

r_spool = 45; // radius of spool hub 
edge_cut=1;   // decreases by edge edge_cut

h = 20;
w = 20;

br = 11.1; // bearing radius with tolerance for insertion
bh = 7;     // bearing height

ir = 4.3;  // threaded rod radius + ample tolerance
t = 4; 
e = 0.02; 

$fn = 64;

// Modules

module cutouts() {
  // make four cutouts (yes, I know I should use a for loop)
  cube([5,100,50], center=true);
  cube([100,5,50], center=true);
  rotate([0,0,45]) cube([5,100,50], center=true);
  rotate([0,0,45]) cube([100,5,50], center=true);
}

module new_hub() {
  difference () {
    union() {
      // base
      difference() {
	cylinder(r=spool_hole_diam/2 + 4, h=3);
	// space for bearing
	translate([0,0,-e]) cylinder(r=br+e, h=h+e);
	cutouts();
      }
      // core which holds 608ZZ bearing
      hub_core();
      // wall
      difference() {
	cylinder(r=spool_hole_diam/2, h=5+spool_wall_thickness, $fn=100);
	translate([0,0,-e]) cylinder(r=spool_hole_diam/2-2, h=6+spool_wall_thickness+1);
	cutouts();
      }
      // torus-shaped ridge using rotate_extrude, yeah!!
      difference() {
	translate([0,0,4.8+spool_wall_thickness])
	  rotate_extrude(convexity = 10, $fn=64)
	  translate([spool_hole_diam/2-0.7, 0, 0])
	    circle(r = 1.7, $fn=64);
	translate([0,0,-e]) cylinder(r=spool_hole_diam/2-2, h=6+spool_wall_thickness+1);
	cutouts();
      }
      // torus-shaped reinforcement
      difference() {
	translate([0,0,3.4])
	  rotate_extrude(convexity = 10, $fn=64)
	  translate([br+4.3, 0, 0])
	    circle(r = 2, $fn=16);
	cutouts();
      }
      // another torus-shaped reinforcement
      difference() {
	translate([0,0,3.4])
	  rotate_extrude(convexity = 10, $fn=64)
	  translate([spool_hole_diam/2-2.1, 0, 0])
	    circle(r = 2, $fn=16);
	cutouts();
      }
    }
  // extra hole at 12 o'clock position
  translate ([0,spool_hole_diam/2+3.9,-1 ]) cylinder(r=5.8, h=40);
  if(bearing_snap_in_helper)translate([0,0,-e])cylinder(r1=br+e+bearing_snap_in_helper_width, r2=br+e, h=bearing_snap_in_helper_height);
  }
}

module hub_core() {
  intersection() {
    difference() {
      cylinder(r1=r_spool, r2=ir, h=h);
      
      // eliminate sharp edge at top
      translate([0,0,h-0.2+1]) cube([100,100,2], center=true);
      
      // space for bearing
      translate([0,0,-e]) intersection() {
        cylinder(r=br+e, h=h+e);
        cylinder(r1=br+bh+e, r2=ir, h=br+bh-ir+e);
      }
      // central hole for threaded rod
      cylinder(r=ir, h=h+e);
    }
  cylinder(r=br+t, h=h);
  }
}

// Print the part

new_hub();

