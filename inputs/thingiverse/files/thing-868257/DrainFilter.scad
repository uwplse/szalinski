// The diameter of the drain to fit.
drain_diam = 33; // [20:100]

// Depth to stick into the drain.
drain_depth = 35; // [0:50]

// The width of the brim.
brim_width = 2.0; // [0:10]

// The height of the brim.
brim_height = 5.0; // [0:25]

// Width of the filter holes.
hole_width = 1.5; // [0.75:0.25:5]

// Height of the filter holes.
hole_height = 12.0; // [0.75:0.25:20]

// Spacing between hole edges.
hole_spacing = 1.5; // [1:5]

// Thickness of filter.
filter_thickness = 2; // [0:5]



///////////////////////////////////////////////////////////////
// Belfry OpenSCAD Library: Placement and Duplication

pi = 3.141592653589793236 * 1.0; // Math makes this not a configurator param.
tau = pi * 2.0;

module right(x) translate([+x,0,0]) children();
module left(x)  translate([-x,0,0]) children();
module back(y)  translate([0,+y,0]) children();
module fwd(y)   translate([0,-y,0]) children();
module up(z)    translate([0,0,+z]) children();
module down(z)  translate([0,0,-z]) children();

module xrot(x) rotate([x,0,0]) children();
module yrot(y) rotate([0,y,0]) children();
module zrot(z) rotate([0,0,z]) children();

module xscale(x) scale([x,1,1]) children();
module yscale(y) scale([1,y,1]) children();
module zscale(z) scale([1,1,z]) children();

module xflip() mirror([1,0,0]) children();
module yflip() mirror([0,1,0]) children();
module zflip() mirror([0,0,1]) children();

module xskew(ya=0,za=0) multmatrix([[1,0,0,0], [tan(ya),1,0,0], [tan(za),0,1,0], [0,0,0,1]]) children();
module yskew(xa=0,za=0) multmatrix([[1,tan(xa),0,0], [0,1,0,0], [0,tan(za),1,0], [0,0,0,1]]) children();
module zskew(xa=0,ya=0) multmatrix([[1,0,tan(xa),0], [0,1,tan(ya),0], [0,0,1,0], [0,0,0,1]]) children();

module mirror_copy(v) {children(); mirror(v) children();}
module xflip_copy() {children(); mirror([1,0,0]) children();}
module yflip_copy() {children(); mirror([0,1,0]) children();}
module zflip_copy() {children(); mirror([0,0,1]) children();}

module move_copies(a=[[0,0,0]]) for (p = a) translate(p) children();
module xrot_copies(rots=[0]) for (r=rots) rotate([r, 0, 0]) children();
module yrot_copies(rots=[0]) for (r=rots) rotate([0, r, 0]) children();
module zrot_copies(rots=[0]) for (r=rots) rotate([0, 0, r]) children();

module xspread(spacing=1,n=2) for (i=[0:n-1]) right((i-(n-1)/2.0)*spacing) children();
module yspread(spacing=1,n=2) for (i=[0:n-1]) back((i-(n-1)/2.0)*spacing) children();
module zspread(spacing=1,n=2) for (i=[0:n-1]) up((i-(n-1)/2.0)*spacing) children();
module spread(p1,p2,n=3) for (i=[0:n-1]) translate(p1+i*(p2-p1)/(n-1)) children();

module xring(n=2,r=0,rot=true) {if (n>0) for (i=[0:n-1]) {a=i*360/n; xrot(a) back(r) xrot(rot?0:-a) children();}}
module yring(n=2,r=0,rot=true) {if (n>0) for (i=[0:n-1]) {a=i*360/n; yrot(a) right(r) yrot(rot?0:-a) children();}}
module zring(n=2,r=0,rot=true) {if (n>0) for (i=[0:n-1]) {a=i*360/n; zrot(a) right(r) zrot(rot?0:-a) children();}}

module grid_of(xa=[0],ya=[0],za=[0]) {for (x=xa,y=ya,z=za) translate([x,y,z]) children();}

///////////////////////////////////////////////////////////////


$fa = 2;
$fs = 2;


filter_ang = atan2(drain_depth, (drain_diam-2*brim_width)/2);
layers = floor(drain_depth / (hole_height+1.0));

up(drain_depth/2) {
	difference() {
		union() {
			difference() {
				cylinder(d=drain_diam-2*brim_width, h=drain_depth, center=true);
				cylinder(d=drain_diam-2*brim_width-2*filter_thickness, h=drain_depth+1, center=true);
				for (layer = [0:layers-1]) {
					level_h = (layers-layer) * (hole_height+hole_spacing) - drain_depth/2 - (hole_height+hole_spacing)/2 + filter_thickness;
					level_r = drain_diam /2;
					level_n = floor((tau*level_r)/(hole_width+hole_spacing));
					up(level_h) {
						zring(n=level_n, r=level_r) {
							cube([filter_thickness*5, hole_width, hole_height], center=true);
						}
					}
				}
			}
			up(drain_depth/2) {
				down(brim_height/2) cylinder(d=drain_diam, h=brim_height, center=true);
				down(brim_height) down(brim_width) cylinder(d1=drain_diam-2*brim_width, d2=drain_diam, h=2*brim_width, center=true);
			}
		}
		up(drain_depth/2) {
			down((2*brim_width+brim_height)/2) {
				cylinder(d1=drain_diam-2*brim_width-2*filter_thickness, d2=drain_diam-2, h=2*brim_width+brim_height+0.05, center=true);
			}
		}
	}
}
difference() {
	up(filter_thickness/2) cylinder(d=drain_diam-2*brim_width, h=filter_thickness, center=true);
	xspread(hole_width+hole_spacing, n=floor(drain_diam/(hole_width+hole_spacing))) {
		yspread(hole_height+hole_spacing, n=floor(drain_diam/(hole_height+hole_spacing))) {
			cube([hole_width, hole_height, filter_thickness*3], center=true);
		}
	}
}


// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
