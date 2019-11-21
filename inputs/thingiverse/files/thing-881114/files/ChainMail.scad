// Size of individual chain links.
link_size = 12; // [5:50]

// Usable print platform width, side to side.
platform_width = 150; // [100:500]

// Usable print platform depth, front to back.
platform_depth = 150; // [100:500]




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


$fa = 1;
$fs = 1;


module link(size) {
	gap = 0.5;
	height = size/3;
	wall = size/6;
	chamfer = wall/2;
	strut = height*2/5 - gap/2;
	render(convexity=6)
	union() {
		difference() {
			cube(size=[size, size, height], center=true);
			xspread(size) {
				yspread(size) {
					zrot(45) {
						cube(size=[chamfer*sqrt(2), chamfer*sqrt(2), height+1], center=true);
					}
				}
			}
			xspread(size) {
				down(height/2) {
					yrot(45) {
						cube(size=[chamfer*sqrt(2), size+1, chamfer*sqrt(2)], center=true);
					}
				}
			}
			yspread(size) {
				up(height/2) {
					xrot(45) {
						cube(size=[size+1, chamfer*sqrt(2), chamfer*sqrt(2)], center=true);
					}
				}
			}
			down(strut) {
				difference() {
					cube(size=[size+1, wall*4, height], center=true);
					yspread(wall*4) {
						up(height/2) {
							xrot(45) {
								cube(size=[size+2, wall/sqrt(2), wall/sqrt(2)], center=true);
							}
						}
					}
				}
			}
			up(strut) {
				difference() {
					cube(size=[wall*4, size+1, height], center=true);
					xspread(wall*4) {
						down(height/2) {
							yrot(45) {
								cube(size=[wall/sqrt(2), size+2, wall/sqrt(2)], center=true);
							}
						}
					}
				}
			}
		}
		up(height/2) {
			difference() {
				xrot(45) {
					cube(size=[size, 2*strut/sqrt(2), 2*strut/sqrt(2)], center=true);
				}
				up(strut+0.5) {
					cube(size=[size+1, strut*2+1, strut*2+1], center=true);
				}
				down(2*strut-0.3) {
					cube(size=[size+1, strut*2, strut*2], center=true);
				}
			}
		}
		down(height/2) {
			difference() {
				yrot(45) {
					cube(size=[2*strut/sqrt(2), size, 2*strut/sqrt(2)], center=true);
				}
				down(strut+0.5) {
					cube(size=[strut*2+1, size+1, strut*2+1], center=true);
				}
			}
		}
		zrot(45) {
			cube(size=[2*strut/sqrt(2), 2*strut/sqrt(2), height], center=true);
		}
	}
}


spacing = link_size * 1.20;
row_count = floor(platform_depth / (spacing/sqrt(2)) - 0.5);
col_count = floor(platform_width / (spacing/sqrt(2)) - 0.5);

difference() {
	up(link_size/6+0.25) {
		xspread(spacing/sqrt(2), n=col_count) {
			yspread(spacing/sqrt(2), n=row_count) {
				zrot(45) link(size=link_size);
			}
		}
	}
	xspread(spacing/sqrt(2), n=col_count) {
		fwd(spacing*(row_count-0.5)/2/sqrt(2)) {
			zrot(-45) right(link_size/4) cube([link_size/2, 0.5, link_size], center=true);
		}
	}
	yspread(spacing/sqrt(2), n=row_count) {
		left(spacing*(col_count-0.5)/2/sqrt(2)) {
			zrot(-45) left(link_size/4) cube([link_size/2, 0.5, link_size], center=true);
		}
	}
}


