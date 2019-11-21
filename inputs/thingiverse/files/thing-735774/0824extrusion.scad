// Created by Heindal at Thingiverse on March 2015

// Values for user to edit

// Length of extrusion
length = 80; // [16,32,48,64,80,96,112,128,144,160,176,192]
// Diameter of holes in extrusion
holeDia = 4.15; // [3.4:3.4mm for Tap, 4.15:4.15mm for Tight Fit, 4.3:4.3mm for Loose Fit]

/* [Hidden] */
//Number of rows of holes in extrusion
rowCount = floor(length/16);
// Calculated values - edit at your own risk
outsideWidth = 8;
outsideHeight = 24;
outsideLength = 16*rowCount-0.1;

module rounded_box(l,w,h,r_edge){

cube(size=[l-2*r_edge,w-2*r_edge,h ],center=true);

for (x = [l/2-r_edge,-(l/2-r_edge) ]) {
	for (y = [(w/2-r_edge),-(w/2-r_edge)]) {
		translate([x,y,0]) cylinder(r1=r_edge,r2=r_edge,h=h,center=true,$fn=40);
	}
}
translate([0,w/2-r_edge,0]) cube(size=[l-2*r_edge,2*r_edge,h ],center=true);
translate([0,-(w/2-r_edge),0]) cube(size=[l-2*r_edge,2*r_edge,h ],center=true);
translate([(l/2-r_edge),0,0]) cube(size=[2*r_edge,w-2*r_edge,h ],center=true);
translate([-(l/2-r_edge),0,0]) cube(size=[2*r_edge,w-2*r_edge,h ],center=true);

}

rotate([90,0,0]) {
	difference() {
		rounded_box(outsideHeight,outsideWidth, outsideLength, 0.5);
		// mounting holes to match the rail
		for (z = [-16*(rowCount-1)/2 : 16 : 16*(rowCount-1)/2]) {
			for (x = [-8,8]) {
				translate([x,0,z]) rotate([90,0,0]) cylinder(r=holeDia/2, h=outsideWidth+1, center=true, $fn=16);
			}
		}
		// mounting holes to match center slot
		for (z =  [-16*rowCount/2 : 16 : 16*rowCount/2]) {
				translate([0,0,z]) rotate([90,0,0]) cylinder(r=holeDia/2, h=outsideWidth+1, center=true, $fn=16);
		}
	}
}
