//////////////////////////////////////////////////
// Parametric Ring Mail

// Diameter of the individual rings.
link_size = 20;  // [10:100]

// Rows of rings to create.
ring_rows = 6;  // [1:100]

// Columns of rings to create.
ring_cols = 9;  // [1:100]


// preview[view:south, tilt:top]

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

module mirror_copy(v) {children(); mirror(v) children();}
module place_copies(a=[[0,0,0]]) {for (p = a) translate(p) children();}
module xrot_copies(rots=[0]) {for (r = rots) rotate([r, 0, 0]) children();}
module yrot_copies(rots=[0]) {for (r = rots) rotate([0, r, 0]) children();}
module zrot_copies(rots=[0]) {for (r = rots) rotate([0, 0, r]) children();}

module xspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (x =[-off:spacing:off]) translate([x, 0, 0]) children();}
module yspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (y =[-off:spacing:off]) translate([0, y, 0]) children();}
module zspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (z =[-off:spacing:off]) translate([0, 0, z]) children();}
module spread(p1,p2,n=2) {d=(p2-p1)/(n-1); for (i=[0:n-1]) translate(p1+d*i) children();}

module xrot_spread(n=2,r=0) {d=360.0/n; for (a=[d:d:360]) rotate([a%360,0,0]) translate([0,r,0]) children();}
module yrot_spread(n=2,r=0) {d=360.0/n; for (a=[d:d:360]) rotate([0,a%360,0]) translate([r,0,0]) children();}
module zrot_spread(n=2,r=0) {d=360.0/n; for (a=[d:d:360]) rotate([0,0,a%360]) translate([r,0,0]) children();}

//////////////////////////////////////////////////


module ringmail_link(size)
{
	sides = 8;
	gap = 0.5;
	height = size/4;
	wall = size/8;
	sidelen = size*sin(360/sides/2);
	difference() {
		zrot(360/sides/2) cylinder(d=size/cos(360/sides/2), h=height, center=true, $fn=sides);
		zrot(360/sides/2) cylinder(d=size/cos(360/sides/2)-2*wall, h=height+1, center=true, $fn=sides);
		up(height/2) {
			cube(size=[size+1, sidelen, height+gap], center=true);
			yspread(sidelen) {
				scale([1, height/2, height/2+gap/2]) {
					xrot(45) cube(size=[size+1, sqrt(2), sqrt(2)], center=true);
				}
			}
		}
		down(height/2) {
			cube(size=[sidelen, size+1, height+gap], center=true);
			xspread(sidelen) {
				scale([height/4, 1, height/2+gap/2]) {
					yrot(45) cube(size=[sqrt(2), size+1, sqrt(2)], center=true);
				}
			}
		}
	}
}


module staggered_mail(size, xcount=20, ycount=12) {
	spread = 1.05;
	xspread(size*spread, n=xcount) {
		yspread(size*spread, n=ycount) {
			children();
		}
	}
	back(size*spread/2) right(size*spread/2) {
		xspread(size*spread, n=xcount) {
			yspread(size*spread, n=ycount) {
				children();
			}
		}
	}
}


staggered_mail(link_size, ring_cols, ring_rows)
	ringmail_link(size=link_size);


// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
