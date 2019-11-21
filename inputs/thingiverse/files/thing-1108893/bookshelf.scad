// parametric bookshelf
// by Jaap
//
//radius of the visible part of the sphere
wall_radius = 400;//[10:2000] 
// thickness of the material
mat_thickness = 9.0;//[2:30]
// how far it sticks out of the wall
shelve_depth = 200;//[1:1000]		
// number of shelves
shelves = 6;//[1:30]		
// cut loss (for laser cutting)
cut_loss = 0.0;
// overcut radius for cnc milling (1/2 mill thickness)
overcut = 0;//[0:15]
// 3D view or DXF output
3dview = 1;//[0:1]

// calculations
sd = shelve_depth;
rv = wall_radius;		// visible radius on wall
r = (pow(rv,2)+pow(sd,2)) / (2 * sd); // sphere radius
h = mat_thickness-cut_loss;	// material heigth in drawing

// openscad precision settings
$fn=30 *1;

// definitions
HORIZ = true;
VERT = false;

module outline() { // debug: draw a sphere
	translate([0,0,rv]) {
		difference() {
			translate([-r+sd,0,0]) sphere(r);
			translate([-2-r*2,-r-1,-r-1]) cube([2+r*2,2+r*2,2+r*2]);
		}
	}
}

module slice(z,step,out) {
rh = sqrt(pow(r,2)-pow(rv-z,2));	// radius slice on current height
cd = r-sd; // center distance: distance radius to x=0
translate([-cd,0,0]) difference() { 
	cylinder(h, rh, rh, true);
	translate([-2*rh+cd,-rh,-1-h/2]) cube([rh*2,rh*2,h+2]);
	for (s=[step/2:step:rv*2]) {
		xoffs = (sqrt(pow(rh,2)-pow(s-rv,2))-cd)/2; // half depth
		xv = out ? cd-1 : cd+xoffs-overcut; // inner or outer?
		xt = out ? xoffs + 1 + overcut : xoffs * 2 + overcut;
		translate([xv,-rv+s-h/2,-1-h/2]) cube([xt,h,h+2]);
	}
  }
}

module sphereit() { // show in 3D
	step = (rv*2)/shelves;
	for(z=[step/2:step:rv*2]) {
		translate([0,0,z]) slice(z,step,HORIZ);
		translate([0,z-rv,rv]) rotate([90,0,0]) slice(z,step,VERT);
	}
}
module flatout() { // show in flat plate for cutting (DXF)
	projection(cut=true) {
		step = (rv*2)/shelves;
		for(z=[step/2:step:rv*2]) {
			translate([z*3,0,0]) slice(z,step,HORIZ);
			translate([z*3,rv*2,0]) slice(z,step,VERT);
		}
	}
}
//outline();
if (3dview) sphereit();
else flatout();
//flatout();
