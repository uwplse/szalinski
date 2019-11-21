//
//	Customizable Fence for N Scale Model Railroads
//	Steve Medwin
//	April 12, 2014
// 

// preview[view:north, tilt:bottom]

Nslats=8*1;
width=0.7*1;
height=6*1;
depth=0.6*1;
spacing=1.5*1;
bar_depth=depth-0.2;
// How many fence sections?
number_sections=2; // [1:20]



module fence() {
// vertical slats
	for (i=[1:Nslats-1]){
		translate([i*spacing,0,0]) cube([width,height,depth]);
		}

// horizontal bars
	translate([0,1,depth]) cube([Nslats*spacing,width,bar_depth]);
	translate([0,height-1.1,depth]) cube([Nslats*spacing,width,bar_depth]);

// vertical post
	translate([0,,-0.250]) cube([width,height+1,depth]);
}

// make fence
for (j=[0:number_sections-1]) {
	translate ([j*Nslats*spacing,0,0]) fence();
}

// end the row of fences
// vertical post
	translate([number_sections*Nslats*spacing,-0.25,0]) cube([width,height+1,depth]);

// horizontal bars
	translate([number_sections*Nslats*spacing,1,depth]) cube([width,width,bar_depth]);
	translate([number_sections*Nslats*spacing,height-1.1,depth]) cube([width,width,bar_depth]);