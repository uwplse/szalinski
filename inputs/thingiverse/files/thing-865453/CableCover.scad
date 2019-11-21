
// Length of cavity to hold connectors.
cavity_length = 50; // [5:100]

// Width of cavity to hold connectors.
cavity_width  = 25; // [5:100]

// Depth of cavity to hold connectors.
cavity_depth  = 10; // [5:100]

// Thickness of the cover's wall.
wall_thickness = 3; // [2:10]

// Diameter of the cable to cover.
cable_diam = 5; // [1:10]


///////////////////////////////////////////////////////////////
// From Belfry OpenSCAD Library: Placement and Duplication

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

module move_copies(a=[[0,0,0]]) {for (p = a) translate(p) children();}
module xrot_copies(rots=[0]) {for (r = rots) rotate([r, 0, 0]) children();}
module yrot_copies(rots=[0]) {for (r = rots) rotate([0, r, 0]) children();}
module zrot_copies(rots=[0]) {for (r = rots) rotate([0, 0, r]) children();}

module xspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (x =[-off:spacing:off]) translate([x, 0, 0]) children();}
module yspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (y =[-off:spacing:off]) translate([0, y, 0]) children();}
module zspread(spacing=1,n=2) {off=spacing*(n-1)/2.0; for (z =[-off:spacing:off]) translate([0, 0, z]) children();}
module spread(p1,p2,n=3) {d=(p2-p1)/(n-1); for (i=[0:n-1]) translate(p1+d*i) children();}

module xring(n=2,r=0,rot=true) {d=360.0/n; for (a=[d:d:360]) xrot(a%360) back(r) xrot(rot?0:-a%360) children();}
module yring(n=2,r=0,rot=true) {d=360.0/n; for (a=[d:d:360]) yrot(a%360) right(r) yrot(rot?0:-a%360) children();}
module zring(n=2,r=0,rot=true) {d=360.0/n; for (a=[d:d:360]) zrot(a%360) right(r) zrot(rot?0:-a%360) children();}

module grid_of(xa=[0],ya=[0],za=[0]) {for (x=xa,y=ya,z=za) translate([x,y,z]) children();}


///////////////////////////////////////////////////////////////
// From Belfry OpenSCAD Library: Shapes

module rrect(size=[1,1,1], r=1, center=false)
{
	translate(center?[0,0,0]:size/2) {
		hull() xspread(size[0]-2*r) {
			hull() yspread(size[1]-2*r) {
				cylinder(r=r, h=size[2], center=true);
			}
		}
	}
}

///////////////////////////////////////////////////////////////


$fa = 1*1;
$fs = 1*1;


module cover_top() {
	up((cavity_depth+wall_thickness)/2) {
		difference() {
			rrect(r=5, size=[cavity_length+2*wall_thickness, cavity_width+2*wall_thickness, cavity_depth+wall_thickness], center=true);
			up(wall_thickness/2+0.05) {
				rrect(r=3, size=[cavity_length+wall_thickness, cavity_width+wall_thickness, cavity_depth], center=true);
			}
			hull() {
				up(wall_thickness/2) {
					grid_of(za=[0, cavity_depth]) {
						yrot(90) cylinder(d=cable_diam, h=cavity_length*2, center=true);
					}
				}
			}
			hull() {
				up(cavity_depth/2+wall_thickness/2-0.99) {
					xspread(cavity_length+wall_thickness-6) {
						yspread(cavity_width+wall_thickness-6) {
							cylinder(r1=3, r2=4, h=2, center=true);
						}
					}
				}
			}
		}
	}
}


module cover_bottom() {
	up((cavity_depth+wall_thickness)/2) {
		down(cavity_depth/2) {
			rrect(r=5, size=[cavity_length+2*wall_thickness, cavity_width+2*wall_thickness, wall_thickness], center=true);
		}
		difference() {
			rrect(r=3, size=[cavity_length+wall_thickness, cavity_width+wall_thickness, cavity_depth], center=true);
			rrect(r=2, size=[cavity_length, cavity_width, cavity_depth+0.05], center=true);
			hull() {
				up(wall_thickness/2) {
					grid_of(za=[0, cavity_depth]) {
						yrot(90) cylinder(d=cable_diam, h=cavity_length*2, center=true);
					}
				}
			}
			up(cavity_depth/2+wall_thickness/2-wall_thickness) {
				difference() {
					up(wall_thickness/2)
						rrect(r=5, size=[cavity_length+2*wall_thickness, cavity_width+2*wall_thickness, wall_thickness], center=true);
					hull() {
						xspread(cavity_length+wall_thickness-6) {
							yspread(cavity_width+wall_thickness-6) {
								up(0.99) cylinder(r1=3, r2=2, h=2, center=true);
							}
						}
					}
				}
			}
		}
	}
}


back((cavity_width+2*wall_thickness)/2+2) cover_top();
fwd((cavity_width+2*wall_thickness)/2+2) cover_bottom();


// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
