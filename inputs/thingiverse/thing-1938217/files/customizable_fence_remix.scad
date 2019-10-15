//
//	Customizable Fence for N Scale Model Railroads
//	Steve Medwin
//	April 12, 2014
// 
//  Derivative by Jonathan Sammon
//  Dec. 14, 2016

// preview[view:north, tilt:bottom]

Nslats=8*1;
width=0.8*1;
height=6*1;
depth=0.6*1;
spacing=1.5*8/7*1;
bar_depth=depth-0.2;
// How many fence sections?
number_sections=2; // [1:20]



module fence() {
// vertical slats
	for (i=[1:Nslats-1]){
		translate([i*spacing+width/4,1,0]) cube([.5,height-2.1,depth]);
		}

// horizontal bars
	translate([0,1,0]) cube([Nslats*spacing,width,depth]);
	translate([0,height-1.1,0]) cube([Nslats*spacing,width,depth]);

// vertical post
	translate([0,0,0]) cube([width,height,depth]);
    translate([-width*.25,height,0]) cube([width*1.5,.5,depth*1.5]);
}

// make fence
for (j=[0:number_sections-1]) {
	translate ([j*Nslats*spacing,0,0]) fence();
}

// end the row of fences
// vertical post
	translate([number_sections*Nslats*spacing,0,0]) cube([width,height,depth]);
    translate([-width*.25+number_sections*Nslats*spacing,height,0]) cube([width*1.5,width/2,depth*1.5]);
// horizontal bars
//	translate([number_sections*Nslats*spacing,1,depth]) cube([width,width,bar_depth]);
//	translate([number_sections*Nslats*spacing,height-1.1,depth]) cube([width,width,bar_depth]);