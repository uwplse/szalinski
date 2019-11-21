//****************************************************
//****************************************************
//General purpose keyed knob.
//by Marc Sulfridge
//****************************************************
//****************************************************

//****************************************************
//Start of user defined parameters.
//****************************************************

//Radius of the rounded fillet at the base of the knob.
fillet_r = 5.588; // [1:10]
//Narrow (bottom) radius of the knob.
min_r = 11.862; // [5:20]
//Wide (top) radius of the knob.
max_r = 13.335; // [5:20]
//Total height of the knob base.
base_h = 20.188; // [5:50]
//Calculated height of the non-fillet portion of the base.
cyl_h = base_h - fillet_r;
//Number of facets for base circle.
base_res = 17; // [10,11,12,13,14,15,16,17,18,19,20]
//Outer shaft radius.
shaft_r = 5.607; // [1:10]
// Shaft height.
shaft_h = 18.1; // [5:50]
//Inner shaft radius.
shaft_in_r = 2.9335; // [0.5:8]
//Width from shaft flat to edge of shaft inner radius.
shaft_in_min_wid = 4.6355; // [0.5:16]
//Number of facets for shaft circle.
shaft_res = 30; // [20,22,24,26,28,30,32,34,36,38,40]
//Thickness of shaft key.
key_th = 1.625; // [0.25:4]
//Width of shaft key from shaft outer radius to end of key.
key_wid = 3.183; // [1:20]
//Number that is large compared to dimensions of the knob.
BIG = 40; // [30,40,50,60,70,80,90,100]
//Fudge factor to ensure overlaps.
dt = 0.01; // [0.001,0.01,0.1]
//****************************************************

// preview[view:north west, tilt:top diagonal]

union(){
	hull(){
		rotate_extrude(convexity = 10){
			translate([min_r-fillet_r, 0])
			circle(r = fillet_r,$fn=base_res);
		}
	cylinder(r1=min_r,r2=max_r,h=cyl_h,center=false,$fn=base_res);
	}

	translate([0,0,cyl_h-dt])
	difference(){
		cylinder(r=shaft_r,h=shaft_h,center=false,$fn=shaft_res);

		difference(){
			cylinder(r=shaft_in_r,h=shaft_h+2*dt,center=false,$fn=shaft_res);

			translate([shaft_in_min_wid-shaft_in_r,-BIG/2,-BIG/2])
			cube([BIG,BIG,BIG],center=false);
		}
	}

	translate([shaft_r-dt,-key_th/2,cyl_h-dt])
	cube([key_wid,key_th,shaft_h+2*dt],center=false);
}

