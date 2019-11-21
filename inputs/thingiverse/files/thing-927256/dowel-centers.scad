// This allows you to make customized dowel centers.
// USAGE: When assembling a wood project with dowels, drill the hole on
// one piece, then insert these.  Press the mating piece together and
// it will give you perfectly-aligned marks for drilling the other side.
//
// Licensed under CreativeCommons-Attribution-ShareAlike
// To fulfil the attribution requirement, please provide a link to:
//		http://www.thingiverse.com/thing:927256

/* [main] */

// The units used for the rest of this page
dowel_units=0; // [0:Inches,1:mm]

dowel_dia=0.3125;

// if =0, will do a best guess
dowel_depth=0;

/* [advanced stuff you probably shouldn't mess with] */

// Magic number to account for drill wobble, etc.
hole_dia_oversize=0.43;

// How deep in mm the anti-friction ribs are.
rib_min_thickness=0.3;

// Thickness in mm of the anti-friction ribs
rib_thickness=0.6;

// How many anti-friction ribs
num_ribs=6;

// How many degrees the anti-friction ribs tilt out (to wedge tightly into the hole)
rib_angle=1;

// How many sides the point has
point_sides=4;

// How big around the point is
point_radius=1.5;

// How tall the point is.  If <0, then it will be 1 1/3 the point_radius
point_height=0;

// How far the rim overhangs (too high could cause printability issues)
rim_overhang=1.5;

rim_thickness=0.6;

// resolution
fn=48;

/* [hidden] */
r=((dowel_units==0?dowel_dia*25.4:dowel_dia)+hole_dia_oversize)/2;
ir=r-rib_min_thickness;
h=dowel_depth<=0?r*4/3:(dowel_units==0?dowel_depth*25.4:dowel_depth);
overhang_r=r+rim_overhang;
point_r=min(point_radius,r*2/3);
point_h=point_height<=0?point_r*4/3:point_height;

cylinder(r=ir,h=h,$fn=fn);
for(a=[0:360/num_ribs:359.99]){
	rotate([0,0,a]) union(){
		rotate([-rib_angle,0,0]) translate([-rib_thickness/2,0,r*sin(rib_angle)]) cube([rib_thickness,r,h]);
		translate([-rib_thickness/2,0,0]) cube([rib_thickness,r,h]); // to prevent a gap at the bottom
	}
}
translate([0,0,h]) cylinder(r2=overhang_r,r1=overhang_r-rim_thickness,h=rim_thickness,$fn=fn);// overhang
translate([0,0,h+rim_thickness]) cylinder(r1=point_r,r2=0.005,h=point_h,$fn=point_sides);// point