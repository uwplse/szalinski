//////////////////////////////////////////////////
// Customizable Filament Spool
//////////////////////////////////////////////////


/* [Size] */

// Diameter of the center spindle hole in mm.
spindle_id = 52; // [10:100]

// Diam of spindle that filament wraps around in mm.
spindle_od = 145; // [40:200]

// Overall outside diameter of spool in mm.
spool_od = 180; // [100:250]

// Overall width of spool in mm.
spool_width = 31; // [20:75]


/* [Spokes] */

// Style of spool walls.
wall_style = "spoked"; // [solid,spoked]

// Number of spokes, if enabled.
spoke_count = 6; // [4:2:12]

// Spoke width, if enabled, in mm.
spoke_width = 12; // [5:25]


/* [Label] */

// Label text to print on side of spool. (Keep it to just a few letters.)
label_text = "";

// Orient label along side or spoke.
label_orient = "side"; // [side,spoke]


/* [Misc] */

// Thickness of spool walls in mm.
spool_wall = 3; // [2:10]

// Diameter of filament holes in mm.
filament_diam = 1.75; // [1.75,3.00]



//////////////////////////////////////////////////
// Belfry SCAD Library

module right(x) {translate([+x,0,0]) children();}
module left(x)  {translate([-x,0,0]) children();}
module back(y)  {translate([0,+y,0]) children();}
module fwd(y)   {translate([0,-y,0]) children();}
module up(z)    {translate([0,0,+z]) children();}
module down(z)  {translate([0,0,-z]) children();}

module xrot(x) {rotate([x,0,0]) children();}
module yrot(y) {rotate([0,y,0]) children();}
module zrot(z) {rotate([0,0,z]) children();}

module xscale(x) {scale([x,1,1]) children();}
module yscale(y) {scale([1,y,1]) children();}
module zscale(z) {scale([1,1,z]) children();}

module xflip() {mirror([1,0,0]) children();}
module yflip() {mirror([0,1,0]) children();}
module zflip() {mirror([0,0,1]) children();}

module mirror_copy(v) {children(); mirror(v) children();}
module place_copies(a=[[0,0,0]]) {for (p = a) translate(p) children();}
module xrot_copies(rots=[0]) {for (r = rots) rotate([r, 0, 0]) children();}
module yrot_copies(rots=[0]) {for (r = rots) rotate([0, r, 0]) children();}
module zrot_copies(rots=[0]) {for (r = rots) rotate([0, 0, r]) children();}

module xspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (x =[-off:spacing:off]) translate([x, 0, 0]) children();}
module yspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (y =[-off:spacing:off]) translate([0, y, 0]) children();}
module zspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (z =[-off:spacing:off]) translate([0, 0, z]) children();}
module spread(p1,p2,n=2) {d=(p2-p1)/(n-1); for (i=[0:n-1]) translate(p1+d*i) children();}

module xring(n=2,r=0) {d=360.0/n; for (a=[d:d:360]) rotate([a%360,0,0]) translate([0,r,0]) children();}
module yring(n=2,r=0) {d=360.0/n; for (a=[d:d:360]) rotate([0,a%360,0]) translate([r,0,0]) children();}
module zring(n=2,r=0) {d=360.0/n; for (a=[d:d:360]) rotate([0,0,a%360]) translate([r,0,0]) children();}

module grid_of(xa=[0],ya=[0],za=[0]) {for (x=xa,y=ya,z=za) translate([x,y,z]) children();}

module chain_hull() {for (i=[0:$children-2]) hull() {children(i); children(i+1);}}

module top_half   (s=100) difference() {children();  down(s/2) cube(s, center=true);}
module bottom_half(s=100) difference() {children();    up(s/2) cube(s, center=true);}
module left_half  (s=100) difference() {children(); right(s/2) cube(s, center=true);}
module right_half (s=100) difference() {children();  left(s/2) cube(s, center=true);}
module front_half (s=100) difference() {children();  back(s/2) cube(s, center=true);}
module back_half  (s=100) difference() {children();   fwd(s/2) cube(s, center=true);}

pi = 3.141592653589793236 + 0;

//////////////////////////////////////////////////


$fa = 2;
$fs = 2;

eps = 0.01 + 0;
spindle_slices = (spoke_count/2) * ceil(spindle_od*pi/spoke_count/50);
snap_indent = spool_wall/3;



module spindle_segments(excess=0) {
	render(4)
	zring(n=spindle_slices) {
		difference() {
			cylinder(h=spool_width, d=spindle_od+excess, center=true);
			cylinder(h=spool_width+2*eps, d=spindle_od-2*spool_wall, center=true);
			up(spool_width/2-spool_wall/4) cylinder(h=spool_wall/2+eps, d2=spindle_od-2*spool_wall+2*snap_indent, d1=spindle_od-2*spool_wall, center=true);
			up(spool_width/2-spool_wall*3/4) cylinder(h=spool_wall/2+eps, d1=spindle_od-2*spool_wall+2*snap_indent, d2=spindle_od-2*spool_wall, center=true);
			xrot(-5) fwd(spindle_od) cube(size=[spindle_od*2, spindle_od*2, spool_width*2], center=true);
			zrot(360/spindle_slices/2) xrot(5) back(spindle_od) cube(size=[spindle_od*2, spindle_od*2, spool_width*2], center=true);
		}
	}
}


module spool() {
	difference() {
		union() {
			up(spool_wall/2) {
				if (wall_style == "spoked") {
					// Spoked walls

					// Outer spool wall ring
					difference() {
						cylinder(h=spool_wall, d=spool_od, center=true);
						cylinder(h=spool_wall+eps*2, d=spool_od-spoke_width*2, center=true);
					}

					// Mid spool wall ring
					difference() {
						cylinder(h=spool_wall, d=spindle_od+spoke_width, center=true);
						cylinder(h=spool_wall+eps*2, d=spindle_od-spool_wall*2-spoke_width, center=true);
					}

					// Inner spool wall ring
					difference() {
						cylinder(h=spool_wall, d=spindle_id+20, center=true);
						cylinder(h=spool_wall+eps*2, d=spindle_id, center=true);
					}

					// Spool wall spokes
					for (ang =[0:(360/spoke_count):359.99]) {
						zrot(ang) {
							right(spool_od/4) {
								cube(size=[spool_od/2-spoke_width/2, spoke_width, spool_wall], center=true);
							}
						}
					}

				} else {
					// Solid walls.

					// Outer spool wall ring
					cylinder(h=spool_wall, d=spool_od, center=true);
				}
			}

			// Spindle wall that filament wraps around
			up(spool_width/2) {
				spindle_segments();
			}
		}

		// Clear spindle hole.
		up(spool_wall/2) {
			cylinder(h=spool_wall+2*eps, d=spindle_id, center=true);
		}

		// Clear out snap holes.
		up(spool_width/2-eps) {
			zflip() {
				zrot(360/(spindle_slices*2)) {
					slop_ang = 0.25 * 360.0 / (spindle_od * pi);
					zrot(slop_ang/2) spindle_segments(excess=snap_indent);
					zrot(-slop_ang/2) spindle_segments(excess=snap_indent);
				}
			}
		}

		// Label text.
		if (label_text != "") {
			linear_extrude(height=1, center=true, convexity=10) {
				xflip() {
					right(spool_od/2-5) {
						if (label_orient == "side") {
							zrot(-90) text(text=label_text, size=spoke_width*0.67, valign="top", halign="center");
						} else {
							right(3) zrot(180) text(text=label_text, size=spoke_width*0.4, valign="bottom");
						}
					}
				}
			}
		}

		// Inner filament holding holes.
		up(spool_wall+filament_diam*1.6/2) {
			zrot(360/spindle_slices/4) {
				right(spindle_od/2) {
					yrot(90) cylinder(h=spindle_od/2, d=filament_diam*1.5, center=true, $fn=12);
				}
			}
		}

		// Outer filament holding holes.
		zrot(45) {
			zring(n=4) {
				right(spool_od/2-5) {
					back(5) xrot(-45) cylinder(h=spool_wall*5, d=filament_diam*1.5, center=true, $fn=8);
					fwd(5) xrot(45) cylinder(h=spool_wall*5, d=filament_diam*1.5, center=true, $fn=8);
				}
			}
		}
	}
}


spool();

// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap

