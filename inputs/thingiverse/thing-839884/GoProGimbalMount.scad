/* [Helmet] */

// The radius of the horizontal curve of the helmet at the mount point.
helmet_x_rad    = 100;  // [75:200]

// The radius of the vertical curve of the helmet at the mount point.
helmet_y_rad    = 100;  // [75:200]

// The width of the wings for mounting to the helmet.
helmet_wings    =  20;  // [0:50]


/* [Gimbal] */

// The diameter of the gimbal's battery holder bar.
gimbal_bar_diam =  25.5;  // [15:50]

// Length of the gimbal bar to grip.
mount_length    =  60;  // [40:80]

// Angle from vertical that the gimbal bar should be held.
clamp_angle     =  15;  // [0:45]


/* [Clamp] */

// Thickness of the clamp wall.
clamp_wall      =   3;  // [2:5]

// Size of the screws to tighten the clamp with.
clamp_screw     =   3;  // [2,2.5,3,4]

// Size of tabs that the screws go in.
clamp_tabs      =  10;  // [7.5:15]



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


$fa=1;
$fs=1;


up(mount_length/2)
difference() {
	union() {
		translate([0, -(gimbal_bar_diam/2+clamp_wall)/2, 0]) {
			cube(size=[gimbal_bar_diam+2*clamp_wall, gimbal_bar_diam/2+clamp_wall, mount_length], center=true);
		}
		translate([0, -(gimbal_bar_diam/2+clamp_wall+50)/2, 0]) {
			difference() {
				cube(size=[gimbal_bar_diam+2*clamp_wall+2*helmet_wings, 40, mount_length], center=true);
				back(20) {
					xspread(gimbal_bar_diam+2*clamp_wall+2*helmet_wings) {
						zrot(45) cube([sqrt(2)*2.5, sqrt(2)*2.5, mount_length+1], center=true);
					}
					up(mount_length/2) {
						xrot(45) cube([gimbal_bar_diam+2*clamp_wall+2*helmet_wings+1, sqrt(2)*2.5, sqrt(2)*2.5], center=true);
					}
				}
			}
		}
		translate([0,mount_length/2*sin(clamp_angle),0]) {
			xrot(clamp_angle) {
				translate([0, -(gimbal_bar_diam/2+clamp_wall)/2, 0]) {
					cube(size=[gimbal_bar_diam+2*clamp_wall, gimbal_bar_diam/2+clamp_wall, mount_length*1.5], center=true);
				}
				cylinder(h=mount_length*1.5, d=gimbal_bar_diam+2*clamp_wall, center=true);
				zspread(mount_length*0.5) {
					translate([0, gimbal_bar_diam/2+clamp_wall-1, 0]) {
						difference() {
							scale([1, 1, 2]) xrot(45) cube(size=clamp_tabs, center=true);
							translate([0, clamp_tabs/3, 0]) {
								yrot(90) cylinder(h=clamp_tabs+1, r=clamp_screw/2*1.1, center=true, $fn=8);
							}
						}
					}
				}
			}
		}
	}
	translate([0,mount_length/2*sin(clamp_angle),0]) {
		xrot(clamp_angle) {
			cylinder(h=mount_length*1.6, d=gimbal_bar_diam, center=true);
			translate([0, gimbal_bar_diam/2, 0]) {
				cube(size=[2, gimbal_bar_diam, mount_length*1.6], center=true);
			}
		}
	}
	translate([0, -(helmet_x_rad+gimbal_bar_diam/2+clamp_wall), 0]) {
		scale([helmet_x_rad, helmet_x_rad, helmet_y_rad]) {
			sphere(r=1, center=true, $fn=50);
		}
	}
	zspread(mount_length+200) {
	    cube(size=200, center=true);
	}
	xspread(gimbal_bar_diam+2*helmet_wings-5) {
		zspread(mount_length/2) {
			translate([0, -(gimbal_bar_diam/2+clamp_wall), 0]) {
				cube(size=[3.1, 20, 16], center=true);
			}
		}
	}
}


// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
